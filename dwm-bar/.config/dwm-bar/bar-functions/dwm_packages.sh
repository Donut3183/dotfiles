#!/bin/sh

dwm_packages(){
  NUMBER_OF_EXPLICIT_PACKAGES=$(pacman -Qe | wc -l)
  NUMBER_OF_EXPLICIT_PACKAGES_TO_BE_UPDATED=$(yay -Qu | wc -l)

  export __DWM_BAR_PACKAGES__="${SEP1} ${NUMBER_OF_EXPLICIT_PACKAGES} 󰏕 ${NUMBER_OF_EXPLICIT_PACKAGES_TO_BE_UPDATED}${SEP2}"

}

dwm_packages
