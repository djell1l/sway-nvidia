# Wayland Variables for NVIDIA to work correctly
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
