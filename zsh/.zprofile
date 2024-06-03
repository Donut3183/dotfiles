# Export the following variables in standard English:

export LIBVIRT_DEFAULT_URI="qemu:///system"

### Stremio scaling
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_ENABLE_HIGHDPI_SCALING=1
### QT apps theming
# export QT_QPA_PLATFORMTHEME=qt6ct

### Matlab
export JAVA_HOME=$(dirname $(dirname $(readlink -f $(which java))))
# export MATLAB_JAVA=$JAVA_HOME

### Matlab prevent grey window
export AWT_TOOLKIT=MToolkit
export _JAVA_AWT_WM_NONREPARENTING=1

### sddm
export LIBSEAT_BACKEND=logind

### Steam, supports fractional scaling
export STEAM_FORCE_DESKTOPUI_SCALING=2.0
