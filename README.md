# sway-nvidia-fork

Enhanced version of sway-nvidia with automatic NVIDIA driver installation and GRUB configuration.

## Features

- Installs NVIDIA DKMS drivers and utils automatically
- Configures GRUB to disable Nouveau and enable nvidia-drm.modeset
- Restores graphical login if TTY override exists
- Prepares Wayland environment variables
- Launches Sway with --unsupported-gpu and noscanout

## Usage

1. Boot into TTY (systemd.unit=multi-user.target)
2. Login as your user
3. Run:
   ```bash
   sudo ./sway-nvidia.sh
