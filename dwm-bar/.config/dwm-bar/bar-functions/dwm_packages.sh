#!/bin/sh

dwm_packages(){
  NUMBER_OF_EXPLICIT_PACKAGES=$(yay -Qe | wc -l)
  NUMBER_OF_EXPLICIT_PACKAGES_TO_BE_UPDATED=$(yay -Qu | wc -l)

  printf " %s 󰏕 %s" "${NUMBER_OF_EXPLICIT_PACKAGES}" "${NUMBER_OF_EXPLICIT_PACKAGES_TO_BE_UPDATED}"

}

dwm_packages
