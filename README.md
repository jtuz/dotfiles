## Set credentials for this dot files

* Irssi
* Github token
* Some `.gitconfig` settings

## Requirements

1. [Tmux](https://github.com/gpakosz/.tmux)
2. [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
3. [httpie](https://httpie.org/)
4. [rbenv](https://github.com/rbenv/rbenv)
5. [pyenv](https://github.com/pyenv/pyenv)
6. [pyenv-virtualenv](https://github.com/pyenv/pyenv-virtualenv)
7. [Kitty Themes](https://github.com/dexpota/kitty-themes)
8. [Ag](https://github.com/ggreer/the_silver_searcher)
9. [RipGrep](https://github.com/BurntSushi/ripgrep)
12. [Flameshoot](https://github.com/flameshot-org/flameshot)
12. [Conky](https://github.com/brndnmtthws/conky)
13. [Rofi Launcher](https://github.com/davatorium/rofi)
14. [Nitrogen](https://github.com/l3ib/nitrogen)
15. [Ueberzug](https://github.com/seebye/ueberzug)
16. [Starship](https://starship.rs/)
17. [Delta](https://github.com/dandavison/delta)
18. [Trayer](https://github.com/sargon/trayer-srg)
19. [JetBrains Nerd Font Patched](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/JetBrainsMono.zip)
20. [Fira Code Nerd Font Patched](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/FiraCode.zip)
21. [3270 Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/3270.zip)
21. [Custom Iosevka Nerd Font](https://github.com/awnion/custom-iosevka-nerd-font)
22. [Font Awesome](https://github.com/FortAwesome/Font-Awesome)


## Enable italics on Kitty terminal using tmux

[based on this reddit post] (https://www.reddit.com/r/vim/comments/24g8r8/italics_in_terminal_vim_and_tmux/)

* Check if italic font is supported:
```
echo -e "\e[3mitalic\e[23m"
```

* Also check:
```
infocmp $TERM | grep sitm
        sgr0=\E(B\E[m, sitm=\E[3m, smacs=\E(0, smam=\E[?7h,
infocmp $TERM | grep ritm
        ri=\EM, rin=\E[%p1%dT, ritm=\E[23m, rmacs=\E(B,
```

If nothing is returned, then here is the step to enable it:
1. Create the file *screen-256color.terminfo* with the following content:
```
# A screen-256color based TERMINFO that adds the escape sequences for italic.
#
# Install:
#
#   tic screen-256color.terminfo
#
# Usage:
#
#   export TERM=screen-256color
#
screen-256color|screen with 256 colors and italic,
        sitm=\E[3m, ritm=\E[23m,
        use=screen-256color,
```
2. Execute the command:
```
tic screen-256color.terminfo
```
3. Add the following lines to *.vimrc*:
```
set t_ZH=^[[3m
set t_ZR=^[[23m
```
**NOTE:** *^[* must be entered with *\<C-V\>\<Esc\>*

4. Add the following line to *.tmux.conf*:
```
set -g default-terminal "screen-256color"
```
**NOTE:** It the step 3 does not work, start tmux using the following command:
```
$ env TERM=screen-256color tmux
```

## Installing I3WM & Xmonad in Arch Linux based distributions

```bash
# fontconfig stuff
yay -S fontconfig lib32-fontconfig ttf-roboto-fontconfig nerd-fonts-fontconfig
yay -S freetype2 lib32-freetype2 cairo siji-git ttf-unifont xorg-fonts-misc ttf-font-awesome
# another tools
yay -S picom-ibhagwan-git xscreensaver trayer-srg
yay -S lua conky blueman arandr lxappearance nitrogen xorg-xrandr redshift acpi parcellite
# i3 stuff
sudo pacman -S i3 i3-gaps i3lock i3status i3blocks
# Xmonad stuff
sudo pacman -S xmonad xmonad-contrib xmonad-utils xmobar xmonad-log
```

## Credits

- To @siduck for his great work with [NvChad](https://github.com/NvChad/NvChad) and [chadwm](https://github.com/siduck/chadwm)
- Derek Taylor for his great work special with xmonad, [Check his repo](https://gitlab.com/dwt1/dotfiles)
