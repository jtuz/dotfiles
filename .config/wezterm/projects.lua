local wezterm = require 'wezterm'
local project_dir = wezterm.home_dir .. "/Workspace"
local M = {}

local function project_dirs()
  -- Start with your home directory as a project, 'cause you might want
  -- to jump straight to it sometimes.
  local projects = { wezterm.home_dir }

  -- WezTerm comes with a glob function! Let's use it to get a lua table
  -- containing all subdirectories of your project folder.
  for _, dir in ipairs(wezterm.glob(project_dir .. '/*')) do
    -- ... and add them to the projects table.
    table.insert(projects, dir)
  end

  return projects
end

function M.choose_project()
  local choices = {}
  for _, value in ipairs(project_dirs()) do
    table.insert(choices, { label = value })
  end

  -- The InputSelector action presents a modal UI for choosing between a set of options
  -- within WezTerm.
  return wezterm.action.InputSelector {
    title = 'Projects',
    -- The options we wish to choose from
    choices = choices,
    -- Yes, we wanna fuzzy search (so typing "trainning" will filter down to
    -- "~/Workspace/trainning/")
    fuzzy = true,
    -- The action we want to perform. Note that this doesn't have to be a
    -- static definition as we've done before, but can be a callback that
    -- evaluates any arbitrary code.
    action = wezterm.action_callback(function(child_window, child_pane, id, label)
      if not label then return end
      -- As a placeholder, we'll log the name of what you picked
      -- wezterm.log_info("Changin Workspace to " .. label)
      -- The SwitchToWorkspace action will switch us to a workspace if it already exists,
      -- otherwise it will create it for us.
      child_window:perform_action(wezterm.action.SwitchToWorkspace {
        -- We'll give our new workspace a nice name, like the last path segment
        -- of the directory we're opening up.
        name = label:match("([^/]+)$"),
        -- Here's the meat. We'll spawn a new terminal with the current working
        -- directory set to the directory that was picked.
        spawn = { cwd = label },
      }, child_pane)
    end),
  }
end

return M
