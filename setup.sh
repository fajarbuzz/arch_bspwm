#!/bin/bash

# Update system
sudo pacman -Syu --noconfirm

# Install essential packages
sudo pacman -S --noconfirm \
    bspwm \
    sxhkd \
    xorg-server \
    xorg-xinit \
    xorg-xrandr \
    xorg-xset \
    xterm \
    dmenu \
    nitrogen \
    rofi \
    feh \
    alacritty \
    firefox \
    zsh \
    lightdm \
    lightdm-gtk-greeter \
    lightdm-gtk-greeter-settings

# Install a few useful utilities and applications
sudo pacman -S --noconfirm \
    vim \
    git \
    networkmanager \
    pulseaudio \
    pavucontrol \
    noto-fonts \
    ttf-dejavu \
    xclip \
    xorg-xinput \
    xdotool \
    clipboard-manager \
    thunar \
    picom

# Enable NetworkManager and LightDM services
sudo systemctl enable NetworkManager
sudo systemctl enable lightdm

# Create basic configuration files
mkdir -p ~/.config/bspwm
mkdir -p ~/.config/sxhkd

# Create bspwm configuration file
cat <<EOL > ~/.config/bspwm/bspwmrc
#!/bin/sh

# Set border width and colors
bspc config border_width 2
bspc config border_color "#3c3c3c"
bspc config focused_border_color "#ff6c6b"

# Set window gaps
bspc config window_gap 10
bspc config outer_padding 10

# Define workspace names
bspc monitor -d I II III IV V VI VII VIII IX X

# Set the initial layout
bspc desktop -l tile
EOL

chmod +x ~/.config/bspwm/bspwmrc

# Create sxhkd configuration file
cat <<EOL > ~/.config/sxhkd/sxhkdrc
# Bindings for bspwm

# Launch terminal
super + Return
    alacritty

# Launch file manager
super + f
    thunar

# Launch browser
super + w
    firefox

# Launch dmenu
super + d
    dmenu_run

# Close focused window
super + q
    bspc node -c

# Change focus
super + {j,k,l,;h}
    bspc node -f {south,north,east,west}
EOL

# Copy .xinitrc file to start bspwm
cat <<EOL > ~/.xinitrc
#!/bin/sh

# Start bspwm and sxhkd
exec bspwm &
exec sxhkd
EOL

chmod +x ~/.xinitrc

# Start LightDM
sudo systemctl start lightdm

echo "Setup completed! Please reboot your system."
