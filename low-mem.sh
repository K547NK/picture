#!/bin/sh

sudo rm -rf /etc/apt/sources.list 
sudo cp sources.list /etc/apt/ 

# Let's get dependecies for our window manager
sudo apt update && sudo aptitude install curl firmware-linux-nonfree firmware-linux-free gcc make dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev -y &&

# Get to cloning and building for the window manager
git clone https://github.com/resloved/i3.git 
cd i3 

# compile & install
autoreconf --force --install 
rm -rf build/ &&
mkdir -p build && cd build/ 

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers &&
make &&
sudo make install &&
cd .. && rm -rf ~/i3 &


mkdir -p ~/.config/polybar && mv ~/Scripts/polybar-config ~/.config/polybar/config &
mkdir ~/.config/i3 && mv ~/Scripts/i3-config ~/.config/i3/config &
mkdir -p ~/.config/rofi/themes && mv ~/Scripts/rofi-launcher.rasi ~/.config/rofi/themes/launcher.rasi & mv ~/Scripts/rofi-config ~/.config/rofi/config &
mkdir ~/.config/zathura && mv ~/Scripts/zathurarc ~/.config/zathura/zathurarc &
mkdir ~/Documents &
mkdir ~/Downloads &
mkdir ~/Music &
mkdir -p ~/Pictures/Screenshots &
cp ~/Scripts/lock.sh ~/.config/i3/ &
cp ~/Scripts/.vimrc ~/ &
cp ~/Scripts/.Xresources ~/ &
rm -rf ~/Scripts

sudo aptitude install pulseaudio pavucontrol zathura tty-clock compton-conf xterm htop vim neofetch neomutt isync msmtp pass notmuch mupdf scrot imagemagick polybar font-manager ranger slim compton python3-pip xorg i3lock feh telegram-desktop rofi -y
sudo apt remove nano vim-tiny -y && sudo apt autoremove && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" && sudo reboot

