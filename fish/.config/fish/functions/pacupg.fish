# Defined in - @ line 1
function pacupg --wraps='sudo apt update && sudo apt upgrade' --description 'alias pacupg=sudo apt update && sudo apt upgrade'
  sudo apt update && sudo apt upgrade $argv;
end
