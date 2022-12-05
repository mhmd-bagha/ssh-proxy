install(){
  if [ $(checkExist) == 0 ]; then
      clear
        echo ' ----------------------------------------------------'
        printf "\n First Install Package [sshpass] Then Restart proxy-ssh. \n \n "
        echo '----------------------------------------------------'
          printf " [1] Debian Ubuntu \n [2] CentOS \n [3] Arch \n [4] SUSE or OpenSUSE \n [5] FreeBSD Unix \n [6] MacOS \n "
          echo '----------------------------------------------------'
          read -p "Your Package Manager: " linux
          if [ 6 -le $linux -o $linux == 0 ]; then
            clear
              printf " \n \n                   !!! Not Exist Package Manager !!!                 \n \n "
              sleep 1.9
              install
          fi
          case $linux in
          1) sudo apt-get install sshpass ;;
          2) sudo dnf install sshpass ;;
          3) sudo pacman -S sshpass ;;
          4) sudo zypper install sshpass ;;
          5) cd /usr/ports/security/sshpass/ && make install clean
            pkg install sshpass ;;
          6) brew install sshpass ;;
          esac
  fi
}

checkExist(){
  if [[ $(sshpass) ]]; then
      echo 1
      else
        echo 0
  fi
}