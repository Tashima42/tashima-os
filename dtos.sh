#!/usr/bin/env bash
#  ____ _____ ___  ____
# |  _ \_   _/ _ \/ ___|   Derek Taylor (DistroTube)
# | | | || || | | \___ \   http://www.youtube.com/c/DistroTube
# | |_| || || |_| |___) |  http://www.gitlab.com/dwt1/
# |____/ |_| \___/|____/
#
# NAME: DTOS
# DESC: An installation and deployment script for DT's Xmonad desktop.
# WARNING: Run this script at your own risk.

if [ "$(id -u)" = 0 ]; then
    echo "This script should NOT be run as root. Run this script as a normal user."
    echo "Instead, you will be asked to enter a root password when necessary."
    exit 1
fi

declare -a standardpkgs=("alacritty"
"bash"
"emacs"
"exa"
"fish"
"htop"
"lolcat"
"lxappearance"
"lxsession"
"maim"
"mpv"
"neovim"
"nitrogen"
"nm-applet"
"opendoas"
"pass"
"pcmanfm"
"qalculate-gtk"
"qt5ct"
"qutebrowser"
"s-tui"
"sxiv"
"ttf-font-awesome"
"ttf-ubuntu-font-family"
"trayer"
"volumeicon"
"xmobar"
"xmonad"
"xmonad-contrib"
"zathura"
"zsh")

declare -a aurpkgs=("mbsync-git"
"mu"
"neovim-plug-git"
"nerd-fonts-mononoki"
"nerd-fonts-source-code-pro"
"picom-jonaburg-git"
"shell-color-scripts"
"starship")

declare -a confs=(".bashrc"
".config/alacritty/alacritty.yml"
".config/fish/config.fish"
".config/nvim/init.vim"
".config/qutebrowser/config.py"
".config/xmobar/trayer-padding-icon.sh"
".config/xmobar/xmobarrc0"
".config/xmobar/xmobarrc1"
".config/xmobar/xmobarrc2"
".doom.d/aliases"
".doom.d/config.el"
".doom.d/config.org"
".doom.d/init.el"
".doom.d/packages.el"
".local/bin/clock"
".local/bin/kernel"
".local/bin/memory"
".local/bin/pacupdate"
".local/bin/upt"
".local/bin/volume"
".xmonad/xmonad.hs"
".xmonad/xmonadctl.hs"
".xmonad/xpm/haskell_20.xpm"
".zshrc")

declare -a directs=(".config/nitrogen"
".doom.d"
".emacs.d"
".xmonad"
"dtdots"
"wallpapers")

error() { \
    clear; printf "ERROR:\\n%s\\n" "$1" >&2; exit 1;
    }

welcome() { \
    dialog --colors --title "\Z5\ZbInstalling DTOS!" --msgbox "\Z2This is a script that will install what I sarcastically call \Z5DTOS (DT's operating system)\Zn\Z2. It's really just an installation script for those that want to try out my XMonad desktop.  We will install the XMonad tiling window manager, the Xmobar panel, the Alacritty terminal, the Fish shell, Doom Emacs and many other essential programs needed to make my dotfiles work correctly.\\n\\n-DT (Derek Taylor, aka DistroTube)" 16 60
    dialog --colors --title "\Z5\ZbStay near your computer!" --yes-label "Continue" --no-label "Exit" --yesno "\Z2This script is not allowed to be run as root. But you will be asked to enter your root password at various points during this installation. This is to give PACMAN and YAY the permissions needed to install software.  Also, make sure you actually have YAY installed before running this script!" 8 60
    }

lastchance() { \
    dialog --colors --title "\Z5\ZbAre You Sure You Want To Do This?" --yes-label "Begin Installation" --no-label "Exit" --yesno "\Z2Shall we begin installing DTOS?" 8 60 || { clear; exit 1; }
    }

installpkg() { \
    # >/dev/null redirects stdout to /dev/null.
    # 2>&1 redirects stderr to be stdout.
    sudo pacman --noconfirm --needed -S "$x" >/dev/null 2>&1 ;
    }

installaur() { \
    yay -S --nocleanmenu --nodiffmenu --noeditmenu --noprovides --noremovemake --useask "$1"
    }

mkdtdots() {
    dialog --colors --title "Making our working directory" --infobox "\Z2Making a directory called  'dtdots' and cd'ing into it." 5 70
    cd "$HOME" || exit
    sleep 1
    mkdir dtdots
    cd dtdots || exit
    }

gitclonedots() {
    dialog --colors --title "Cloning dotfiles" --infobox "\Z2Cloning the 'dotfiles' and 'wallpapers' repositories from DT's GitLab." 5 70
    sleep 1
    git clone https://gitlab.com/dwt1/dotfiles.git
    git clone https://gitlab.com/dwt1/wallpapers.git
    }

loginmanager() { \
    dialog --colors --title "\Z5\ZbInstallation Complete!" --msgbox "\Z2Now logout of your current desktop environment or window manager and choose XMonad from your login manager.  ENJOY!" 10 60
    }

sudo pacman --noconfirm --needed -Sy dialog || error "Error!"

welcome || error "User exited."

lastchance || error "User exited."

for x in "${standardpkgs[@]}"; do
    dialog --colors --title "Installing packages from Arch repo" --infobox "\Z2Installing \`$x\` from the Arch repositories." 5 70
    installpkg "$x"
done

for x in "${directs[@]}"; do
    dialog --colors --title "Backing up some files and directories" --infobox "\Z2Since \`$HOME/$x\` already exists, we will make a backup at \`$HOME/$x.$(date +%Y%m%d%H%M)\`." 5 70
    [ -d "$HOME/$x" ] && mv "$HOME/$x" "$HOME/$x.$(date +%Y%m%d%H%M)"
done

for x in "${confs[@]}"; do
    dialog --colors --title "Backing up some files and directories" --infobox "\Z2Since \`$HOME/$x\` already exists, we will make a backup at \`$HOME/$x.$(date +%Y%m%d%H%M)\`." 5 70
    [ -f "$HOME/$x" ] && mv "$HOME/$x" "$HOME/$x.$(date +%Y%m%d%H%M)"
done

mkdtdots || error "Error making 'dtdots' directory or cd'ing into it."

gitclonedots || error "Error cloning DT's dotfiles or wallpapers repo from GitLab."

for x in "${directs[@]}"; do
    dialog --colors --title "Installing the new config files" --infobox "\Z2Copying the new config files to their appropriate locations." 5 70
    [ -d "$x" ] &&
    mv "$x" "$HOME/$x"
done

for x in "${directs[@]}"; do
    dialog --colors --title "Installing the new config files" --infobox "\Z2Copying the new config files to their appropriate locations." 5 70
    [ -d "dotfiles/$x" ] &&
    mv "dotfiles/$x" "$HOME/$x"
done

for x in "${confs[@]}"; do
    dialog --colors --title "Installing the new config files" --infobox "\Z2Copying the new config files to their appropriate locations." 5 70
    [ -f "dotfiles/$x" ] &&
    mkdir --parents "$HOME/$(echo "$x" | awk 'BEGIN { FS = "/" } ; { OFS = FS } ; { $NF="" ; print $0 }')" &&
    mv "dotfiles/$x" "$HOME/$x"
done

for x in "${aurpkgs[@]}"; do
    installaur "$x"
done

sudo mv "$HOME"/.xmonad/pacman-hooks/recompile-xmonad.hook "$HOME"/.xmonad/pacman-hooks/recompile-xmonadh.hook /etc/pacman.d/hooks/

dialog --colors --title "Installing Doom Emacs" --infobox "\Z2A major component of DTOS is Doom Emacs. So let's install it!" 5 70
sleep 1
git clone --depth 1 https://github.com/hlissner/doom-emacs "$HOME"/.emacs.d
"$HOME"/.emacs.d/bin/doom install

xmonad --recompile
ghc -dynamic "$HOME"/.xmonad/xmonadctl.hs

old_home="/home/dt"
sed -i "s#$old_home#$HOME#g" "$HOME/.config/nitrogen/nitrogen.cfg" "$HOME/.config/nitrogen/bg-saved.cfg"

cd "$HOME" || exit
rm -rf dtdots

loginmanager || error "User exited."
