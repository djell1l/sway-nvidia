#!/bin/bash
# One-step NVIDIA + Sway launch for LainOS
# Run from TTY as root

echo "1️⃣ Installing NVIDIA drivers..."
sudo pacman -Sy --noconfirm linux-headers dkms
sudo pacman -S --noconfirm nvidia-dkms nvidia-utils
sudo mkinitcpio -P

echo "2️⃣ Configuring GRUB..."
GRUB_FILE="/etc/default/grub"
if ! grep -q "rd.driver.blacklist=nouveau" $GRUB_FILE; then
    sudo sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"/GRUB_CMDLINE_LINUX_DEFAULT="\1 rd.driver.blacklist=nouveau nvidia-drm.modeset=1"/' $GRUB_FILE
    sudo grub-mkconfig -o /boot/grub/grub.cfg
    echo "GRUB updated."
else
    echo "GRUB already configured for NVIDIA."
fi

echo "3️⃣ Restoring graphical login if needed..."
TTY_OVERRIDE="/etc/systemd/system/getty@tty1.service.d/override.conf"
if [ -f "$TTY_OVERRIDE" ]; then
    sudo rm -f "$TTY_OVERRIDE"
    sudo systemctl daemon-reexec
fi

echo "4️⃣ Preparing Wayland environment..."
export WLR_NO_HARDWARE_CURSORS=1
export WLR_RENDERER=vulkan
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export MOZ_ENABLE_WAYLAND=1
export MOZ_USE_XINPUT2=1
export GBM_BACKEND=nvidia-drm
export __GLX_VENDOR_LIBRARY_NAME=nvidia
export XWAYLAND_NO_GLAMOR=1

echo "5️⃣ Launching Sway..."
exec sway --unsupported-gpu -D noscanout
