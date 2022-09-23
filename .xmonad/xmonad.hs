import           Control.Monad                         ( replicateM_ )
import           Data.Foldable                         ( traverse_ )
import           Data.Monoid
import           Graphics.X11.ExtraTypes.XF86
import           System.Exit
import           System.IO                             ( hPutStr
                                                       , hClose
                                                       )
import           XMonad
import           XMonad.Actions.CycleWS                ( Direction1D(..)
                                                       , anyWS
                                                       , findWorkspace
                                                       )
import           XMonad.Actions.DynamicProjects        ( Project(..)
                                                       , dynamicProjects
                                                       , switchProjectPrompt
                                                       )
import           XMonad.Actions.DynamicWorkspaces      ( removeWorkspace )
import           XMonad.Actions.FloatKeys              ( keysAbsResizeWindow
                                                       , keysResizeWindow
                                                       )
import           XMonad.Actions.RotSlaves              ( rotSlavesUp )
import           XMonad.Actions.SpawnOn                ( manageSpawn
                                                       , spawnOn
                                                       )
import           XMonad.Actions.WithAll                ( killAll )
import           XMonad.Hooks.EwmhDesktops             ( ewmh
                                                       , ewmhDesktopsEventHook
                                                       , ewmhFullscreen
                                                       , fullscreenEventHook
                                                       )
import           XMonad.Hooks.FadeInactive             ( fadeInactiveLogHook )
import           XMonad.Hooks.InsertPosition           ( Focus(Newer)
                                                       , Position(Below)
                                                       , insertPosition
                                                       )
import           XMonad.Hooks.ManageDocks              ( Direction2D(..)
                                                       , ToggleStruts(..)
                                                       , avoidStruts
                                                       , docks
                                                       , docksEventHook
                                                       )
import           XMonad.Hooks.ManageHelpers            ( (-?>)
                                                       , composeOne
                                                       , doCenterFloat
                                                       , doFullFloat
                                                       , isDialog
                                                       , isFullscreen
                                                       , isInProperty
                                                       )
import           XMonad.Hooks.UrgencyHook              ( UrgencyHook(..)
                                                       , withUrgencyHook

                                                       )
import           XMonad.Hooks.WindowSwallowing
import           XMonad.Layout.Gaps                    ( gaps )
import           XMonad.Layout.MultiToggle             ( Toggle(..)
                                                       , mkToggle
                                                       , single
                                                       )
import           XMonad.Layout.MultiToggle.Instances   ( StdTransformers(NBFULL) )
import           XMonad.Layout.NoBorders               ( smartBorders )
import           XMonad.Layout.PerWorkspace            ( onWorkspace )
import           XMonad.Layout.Spacing                 ( spacing )
import           XMonad.Layout.ThreeColumns            ( ThreeCol(..) )
import           XMonad.Prompt                         ( XPConfig(..)
                                                       , amberXPConfig
                                                       , XPPosition(CenteredAt)
                                                       )
import           XMonad.Util.EZConfig                  ( mkNamedKeymap )
import           XMonad.Util.NamedActions              ( (^++^)
                                                       , NamedAction (..)
                                                       , addDescrKeys'
                                                       , addName
                                                       , showKm
                                                       , subtitle
                                                       )
import           XMonad.Util.NamedScratchpad           ( NamedScratchpad(..)
                                                       , customFloating
                                                       , defaultFloating
                                                       , namedScratchpadAction
                                                       , namedScratchpadManageHook
                                                       )
import           XMonad.Util.Run                       ( safeSpawn
                                                       , spawnPipe
                                                       )
import           XMonad.Util.SpawnOnce                 ( spawnOnce )
import           XMonad.Util.WorkspaceCompare          ( getSortByIndex )

import qualified Control.Exception                     as E
import qualified Data.Map                              as M
import qualified XMonad.StackSet                       as W
import qualified XMonad.Util.NamedWindows              as W

-- Imports for Polybar --
import qualified Codec.Binary.UTF8.String              as UTF8
import qualified DBus                                  as D
import qualified DBus.Client                           as D
import           XMonad.Hooks.DynamicLog

main :: IO ()
main = mkDbusClient >>= main'

main' :: D.Client -> IO ()
main' dbus = xmonad . docks . ewmh . dynProjects . keybindings . urgencyHook $ def
  { terminal           = myTerminal
  , focusFollowsMouse  = False
  , clickJustFocuses   = False
  , borderWidth        = 2
  , modMask            = myModMask
  , workspaces         = myWS
  , normalBorderColor  = "#444444" -- Gruvbox gray
  , focusedBorderColor = "#076688" -- Gruvbox blue
  , mouseBindings      = myMouseBindings
  , layoutHook         = myLayout
  , manageHook         = myManageHook
  , handleEventHook    = myEventHook
  , logHook            = myPolybarLogHook dbus
  , startupHook        = myStartupHook
  }
 where
  myModMask   = mod4Mask -- super as the mod key
  dynProjects = dynamicProjects projects
  keybindings = addDescrKeys' ((myModMask, xK_F1), showKeybindings) myKeys
  urgencyHook = withUrgencyHook LibNotifyUrgencyHook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
-- myStartupHook = startupHook def
myStartupHook = do
  spawn "$HOME/.xmonad/scripts/autostart.sh"

-- original idea: https://pbrisbin.com/posts/using_notify_osd_for_xmonad_notifications/
data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
  urgencyHook LibNotifyUrgencyHook w = do
    name     <- W.getName w
    maybeIdx <- W.findTag w <$> gets windowset
    traverse_ (\i -> safeSpawn "notify-send" [show name, "workspace " ++ i]) maybeIdx

------------------------------------------------------------------------
-- Polybar settings (needs DBus client).
--
mkDbusClient :: IO D.Client
mkDbusClient = do
  dbus <- D.connectSession
  D.requestName dbus (D.busName_ "org.xmonad.log") opts
  return dbus
 where
  opts = [D.nameAllowReplacement, D.nameReplaceExisting, D.nameDoNotQueue]

-- Emit a DBus signal on log updates
dbusOutput :: D.Client -> String -> IO ()
dbusOutput dbus str =
  let opath  = D.objectPath_ "/org/xmonad/Log"
      iname  = D.interfaceName_ "org.xmonad.Log"
      mname  = D.memberName_ "Update"
      signal = D.signal opath iname mname
      body   = [D.toVariant $ UTF8.decodeString str]
  in  D.emit dbus $ signal { D.signalBody = body }

polybarHook :: D.Client -> PP
polybarHook dbus =
  let wrapper c s | s /= "NSP" = wrap ("%{F" <> c <> "} ") " %{F-}" s
                  | otherwise  = mempty
      green   = "#61C766"
      gray   = "#6D8895"
      orange = "#E57C46"
      blue = "#42A6F5"
      red    = "#EC7875"
  in  def { ppOutput          = dbusOutput dbus
          , ppCurrent         = wrapper green
          , ppVisible         = wrapper gray
          , ppUrgent          = wrapper orange
          , ppHidden          = wrapper gray
          , ppHiddenNoWindows = wrapper red
          , ppTitle           = shorten 100 . wrapper blue
          }

myPolybarLogHook dbus = myLogHook <+> dynamicLogWithPP (polybarHook dbus)

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--

screenshootDir  = "/home/jtuzp/Pictures/Screenshots"
myTerminal      = "kitty"
appIconLauncher = "rofi -modi drun,ssh,window -show drun -show-icons -opacity 60 -lines 5 -font \"3270Medium Nerd Font Mono 17\""
appTextLauncher = "rofi -show run -opacity 60 -lines 5 -font \"3270Medium Nerd Font Mono 17\""
keyboardLayout  = "setxkbmap -rules evdev -model evdev -layout us -variant altgr-intl"
screenshot      =  "flameshot gui -p " ++ screenshootDir
fullScreenshot  =  "flameshot full -p " ++ screenshootDir
delayFullScreenshot =  "flameshot full -d 2000 -p " ++ screenshootDir
screenLocker    = "xscreensaver-command -lock"
playerctl c     = "playerctl --player=spotify,%any " <> c

showKeybindings :: [((KeyMask, KeySym), NamedAction)] -> NamedAction
showKeybindings x = addName "Show Keybindings" . io $
  E.bracket (spawnPipe $ getAppCommand yad) hClose (\h -> hPutStr h (unlines $ showKm x))

myKeys conf@XConfig {XMonad.modMask = modm} =
  keySet "Applications"
    [ 
     key "Web Browser"   (modm .|. shiftMask  , xK_w       ) $ spawn "firefox"
    ] ^++^
  keySet "Audio"
    [ key "Mute"          (0, xF86XK_AudioMute              ) $ spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle"
    , key "Lower volume"  (0, xF86XK_AudioMicMute           ) $ spawn "pactl set-source-mute @DEFAULT_SINK@ toggle"
    , key "Lower volume"  (0, xF86XK_AudioLowerVolume       ) $ spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%"
    , key "Raise volume"  (0, xF86XK_AudioRaiseVolume       ) $ spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%"
    , key "Play / Pause"  (0, xF86XK_AudioPlay              ) $ spawn $ playerctl "play-pause"
    , key "Stop"          (0, xF86XK_AudioStop              ) $ spawn $ playerctl "stop"
    , key "Previous"      (0, xF86XK_AudioPrev              ) $ spawn $ playerctl "previous"
    , key "Next"          (0, xF86XK_AudioNext              ) $ spawn $ playerctl "next"
    ] ^++^
  keySet "Launchers"
    [ key "Terminal"      (modm .|. shiftMask       , xK_Return  ) $ spawn (XMonad.terminal conf)
    , key "Apps (Rofi)"   (modm .|. mod1Mask        , xK_space   ) $ spawn appIconLauncher
    , key "Apps (Rofi)"   (modm .|. mod1Mask        , xK_d       ) $ spawn appTextLauncher
    , key "Lock screen"   (controlMask .|. mod1Mask , xK_l       ) $ spawn screenLocker
    ] ^++^
  keySet "Layouts"
    [ key "Next"          (modm              , xK_space     ) $ sendMessage NextLayout
    , key "Reset"         (modm .|. shiftMask, xK_space     ) $ setLayout (XMonad.layoutHook conf)
    , key "Fullscreen"    (modm              , xK_f         ) $ sendMessage (Toggle NBFULL)
    ] ^++^
  keySet "Polybar"
    [ key "Toggle"        (modm              , xK_equal     ) togglePolybar
    ] ^++^
  keySet "Projects"
    [ key "Switch prompt" (modm              , xK_o         ) $ switchProjectPrompt projectsTheme
    ] ^++^
  keySet "Scratchpads"
    [ key "Files"           (modm .|. controlMask,  xK_f    ) $ runScratchpadApp nemo
    , key "Screen recorder" (modm .|. controlMask,  xK_r    ) $ runScratchpadApp scr
    , key "Spotify"         (modm .|. controlMask,  xK_s    ) $ runScratchpadApp spotify
    ] ^++^
  keySet "Screens" switchScreen ^++^
  keySet "System"
    [ key "Toggle status bar gap"    (modm               , xK_b ) toggleStruts
    , key "Logout (quit XMonad)"     (modm .|. shiftMask , xK_q ) $ io exitSuccess
    , key "Restart XMonad"           (modm .|. shiftMask , xK_r ) $ spawn "xmonad --recompile; xmonad --restart"
    -- This works with a keyboard with Print Screen Key
    -- , key "Capture entire screen"    (0                  , xK_Print ) $ spawn fullScreenshot
    -- , key "Capture section screen"   (modm               , xK_Print ) $ spawn screenshot
    -- , key "Capture entire screen(d)" (mod1Mask           , xK_Print ) $ spawn delayFullScreenshot
    -- This works with my Keychron K6
    , key "Capture entire screen"    (controlMask .|. shiftMask , xK_3 ) $ spawn fullScreenshot
    , key "Capture section screen"   (controlMask .|. shiftMask , xK_4 ) $ spawn screenshot
    , key "Capture entire screen(d)" (controlMask .|. shiftMask , xK_5 ) $ spawn delayFullScreenshot
    , key "Keyboard Layout"          (modm .|. mod1Mask  , xK_k ) $ spawn keyboardLayout
    ] ^++^
  keySet "Windows"
    [ key "Close focused"   (modm              , xK_q        ) kill
    , key "Close all in ws" (modm .|. shiftMask, xK_BackSpace) killAll
    , key "Refresh size"    (modm              , xK_n        ) refresh
    , key "Focus next"      (modm              , xK_j        ) $ windows W.focusDown
    , key "Focus previous"  (modm              , xK_k        ) $ windows W.focusUp
    , key "Focus master"    (modm              , xK_m        ) $ windows W.focusMaster
    , key "Swap master"     (modm              , xK_Return   ) $ windows W.swapMaster
    , key "Swap next"       (modm .|. shiftMask, xK_j        ) $ windows W.swapDown
    , key "Swap previous"   (modm .|. shiftMask, xK_k        ) $ windows W.swapUp
    , key "Shrink master"   (modm              , xK_h        ) $ sendMessage Shrink
    , key "Expand master"   (modm              , xK_l        ) $ sendMessage Expand
    , key "Switch to tile"  (modm              , xK_t        ) $ withFocused (windows . W.sink)
    , key "Rotate slaves"   (modm .|. shiftMask, xK_Tab      ) rotSlavesUp
    , key "Decrease size"   (modm              , xK_d        ) $ withFocused (keysResizeWindow (-10,-10) (1,1))
    , key "Increase size"   (modm              , xK_s        ) $ withFocused (keysResizeWindow (10,10) (1,1))
    , key "Decr  abs size"  (modm .|. shiftMask, xK_d        ) $ withFocused (keysAbsResizeWindow (-10,-10) (1024,752))
    , key "Incr  abs size"  (modm .|. shiftMask, xK_s        ) $ withFocused (keysAbsResizeWindow (10,10) (1024,752))
    ] ^++^
  keySet "Workspaces"
    [ key "Next"          (modm              , xK_period    ) nextWS'
    , key "Previous"      (modm              , xK_comma     ) prevWS'
    , key "Remove"        (modm .|. shiftMask, xK_F4        ) removeWorkspace
    ] ++ switchWsById
 where
  togglePolybar = spawn "polybar-msg cmd toggle &"
  toggleStruts = togglePolybar >> sendMessage ToggleStruts
  keySet s ks = subtitle s : ks
  key n k a = (k, addName n a)
  action m = if m == shiftMask then "Move to " else "Switch to "
  -- mod-[1..9]: Switch to workspace N | mod-shift-[1..9]: Move client to workspace N
  switchWsById =
    [ key (action m <> show i) (m .|. modm, k) (windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
  -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
  -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
  switchScreen =
    [ key (action m <> show sc) (m .|. modm, k) (screenWorkspace sc >>= flip whenJust (windows . f))
        | (k, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m)  <- [(W.view, 0), (W.shift, shiftMask)]]

----------- Cycle through workspaces one by one but filtering out NSP (scratchpads) -----------

nextWS' = switchWS Next
prevWS' = switchWS Prev

switchWS dir =
  findWorkspace filterOutNSP dir anyWS 1 >>= windows . W.view

filterOutNSP =
  let g f xs = filter (\(W.Workspace t _ _) -> t /= "NSP") (f xs)
  in  g <$> getSortByIndex

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings XConfig {XMonad.modMask = modm} = M.fromList

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w
                                      >> windows W.shiftMaster)

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w
                                      >> windows W.shiftMaster)

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout =
  avoidStruts
    . smartBorders
    . fullScreenToggle
    . comLayout
    . devLayout
    . webLayout
    . wrkLayout $ (tiled ||| Mirror tiled ||| column3 ||| full)
   where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = gapSpaced 4 $ Tall nmaster delta ratio
     full    = gapSpaced 1 Full
     column3 = gapSpaced 3 $ ThreeColMid 1 (3/100) (1/2)

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

     -- Gaps bewteen windows
     myGaps gap  = gaps [(U, gap),(D, gap),(L, gap),(R, gap)]
     gapSpaced g = spacing g . myGaps g

     -- Per workspace layout
     comLayout = onWorkspace comWs (column3 ||| Mirror tiled ||| full ||| tiled)
     devLayout = onWorkspace devWs (column3 ||| Mirror tiled ||| full ||| tiled)
     webLayout = onWorkspace trmWs (column3 ||| Mirror tiled ||| full ||| tiled)
     wrkLayout = onWorkspace wrkWs (column3 ||| Mirror tiled ||| full ||| tiled)

     -- Fullscreen
     fullScreenToggle = mkToggle (single NBFULL)

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--

type AppName      = String
type AppTitle     = String
type AppClassName = String
type AppCommand   = String

data App
  = ClassApp AppClassName AppCommand
  | TitleApp AppTitle AppCommand
  | NameApp AppName AppCommand
  deriving Show

calendar       = ClassApp "Gnome-calendar"       "gnome-calendar"
eog            = NameApp  "eog"                  "eog"
evince         = ClassApp "Evince"               "evince"
gimp           = ClassApp "Gimp"                 "gimp"
nemo           = ClassApp "Nemo"                 "nemo"
galculator     = ClassApp "Galculator"           "galculator"
uno_calculator = ClassApp "Calculator.Skia.Gtk"  "uno-calculator"
office         = ClassApp "libreoffice-draw"     "libreoffice-draw"
pavuctrl       = ClassApp "Pavucontrol"          "pavucontrol"
scr            = ClassApp "SimpleScreenRecorder" "simplescreenrecorder"
spotify        = ClassApp "Spotify"              "myspotify"
vlc            = ClassApp "Vlc"                  "vlc"
yad            = ClassApp "Yad"                  "yad --text-info --text 'XMonad'"

myManageHook = manageApps <+> manageSpawn <+> manageScratchpads
 where
  isBrowserDialog     = isDialog <&&> className =? "Brave-browser"
  isFileChooserDialog = isRole =? "GtkFileChooserDialog"
  isPopup             = isRole =? "pop-up"
  isSplash            = isInProperty "_NET_WM_WINDOW_TYPE" "_NET_WM_WINDOW_TYPE_SPLASH"
  isRole              = stringProperty "WM_WINDOW_ROLE"
  tileBelow           = insertPosition Below Newer
  doCalendarFloat   = customFloating (W.RationalRect (11 / 15) (1 / 48) (1 / 8) (1 / 8))
  manageScratchpads = namedScratchpadManageHook scratchpads
  anyOf :: [Query Bool] -> Query Bool
  anyOf = foldl (<||>) (pure False)
  match :: [App] -> Query Bool
  match = anyOf . fmap isInstance
  manageApps = composeOne
    [ isInstance calendar                      -?> doCalendarFloat
    , match [ gimp, office ]                   -?> doFloat
    , match [ eog
            , nemo
            , galculator
            , uno_calculator
            , pavuctrl
            , scr
            ]                                  -?> doCenterFloat
    , match [ evince, spotify, vlc, yad ] -?> doFullFloat
    , resource =? "desktop_window"             -?> doIgnore
    , resource =? "kdesktop"                   -?> doIgnore
    , anyOf [ isBrowserDialog
            , isFileChooserDialog
            , isDialog
            , isPopup
            , isSplash
            ]                                  -?> doCenterFloat
    , isFullscreen                             -?> doFullFloat
    , pure True                                -?> tileBelow
    ]

isInstance (ClassApp c _) = className =? c
isInstance (TitleApp t _) = title =? t
isInstance (NameApp n _)  = appName =? n

getNameCommand (ClassApp n c) = (n, c)
getNameCommand (TitleApp n c) = (n, c)
getNameCommand (NameApp  n c) = (n, c)

getAppName    = fst . getNameCommand
getAppCommand = snd . getNameCommand

scratchpadApp :: App -> NamedScratchpad
scratchpadApp app = NS (getAppName app) (getAppCommand app) (isInstance app) defaultFloating

runScratchpadApp = namedScratchpadAction scratchpads . getAppName

scratchpads = scratchpadApp <$> [ nemo, scr, spotify ]

------------------------------------------------------------------------
-- Workspaces
--
trmWs = "\xf120" -- trm
webWs = "\xf0ac" -- web
devWs = "\xf121" -- dev
comWs = "\xf086" -- com
wrkWs = "\xf085" -- wrk
sysWs = "\xf025" -- media
etcWs = "\xf069" -- etc

myWS :: [WorkspaceId]
myWS = [trmWs, webWs, devWs, comWs, wrkWs, sysWs, etcWs]

------------------------------------------------------------------------
-- Dynamic Projects
--
projects :: [Project]
projects = [
  -- [ Project { projectName      = trmWs
            -- , projectDirectory = "~/"
            -- , projectStartHook = Just $ spawn myTerminal
            -- }
  -- , Project { projectName      = webWs
            -- , projectDirectory = "~/"
            -- , projectStartHook = Just $ spawn "firefox"
            -- }
  -- , Project { projectName      = devWs
            -- , projectDirectory = "~/workspace/cr/app"
            -- , projectStartHook = Just . replicateM_ 2 $ spawn myTerminal
            -- }
  -- , Project { projectName      = comWs
            -- , projectDirectory = "~/"
            -- , projectStartHook = Just $ do spawn "telegram-desktop"
                                           -- spawn "element-desktop"
                                           -- spawn "signal-desktop"
            -- }
  -- , Project { projectName      = wrkWs
            -- , projectDirectory = "~/"
            -- , projectStartHook = Just $ spawn "firefox -P 'chatroulette' -no-remote"
            -- }
  -- , Project { projectName      = sysWs
            -- , projectDirectory = "/etc/nixos/"
            -- , projectStartHook = Just . spawn $ myTerminal <> " -e sudo su"
            -- }
  -- , Project { projectName      = etcWs
            -- , projectDirectory = "~/"
            -- , projectStartHook = Nothing
            -- }
  ]

projectsTheme :: XPConfig
projectsTheme = amberXPConfig
  { bgHLight = "#002b36"
  , fgHLight = "#B8BB26"
  , font     = "xft:UbuntuMono Nerd Font:size=12:antialias=true"
  , height   = 60
  , position = CenteredAt 0.5 0.5
  }

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- myEventHook = docks <+> ewmh <+> ewmhFullscreen
-- myEventHook = docksEventHook <+> ewmhDesktopsEventHook <+> fullscreenEventHook
myEventHook
  = swallowEventHook (className =? "kitty"
                 <||> className =? "XTerm") (return True)

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = fadeInactiveLogHook 0.9
