# include file ssh
source ssh.sh
source install-sshpass.sh
DIRECTORY="/etc/proxy-ssh"
FILE="config"
pathFile="$DIRECTORY/$FILE"

start() {
  # install dir and file configuration
  # install ssh pass
  configCreate # configuration ssh file
  install # install ssh pass
  # messages and start program
  echo "              ------------------------------------------"
  printf "                        Welcome To Ssh Proxy... \n \n                        Please Select A Number!... \n"
  echo "              ------------------------------------------"
  printf "\n [1] Add a Proxy \n [2] Connect to a Proxy \n [3] Delete a Proxy \n \n "
  read -p 'Number: ' number_proxy
  case $number_proxy in
  1) addProxy ;;
  2) getProxy ;;
  3) deleteProxy ;;
  *)
    echo "Not Validate Argument"
    start
    ;;
  esac
}

configCreate() {
  clear
  # create folder
  if [ ! -d $DIRECTORY ]; then
    echo "installing directory config ..."
    sudo mkdir $DIRECTORY
    echo "installed directory config ..."
    sleep 1.5
    start
  fi
  # create file
  if [ ! -f $pathFile ]; then
    echo "installing file config ..."
    sudo touch $pathFile
    sudo chmod +r+w+x $pathFile
    echo "installed file config ..."
    sleep 1.5
    start
  fi
}

addProxy() {
  clear
  printf "create a ssh server... \n"
  echo "---------------------------"
  read -p "SSH server: " server
  read -p "SSH username: " username
  read -p "SSH password: " password
  read -p "SSH port is default(22). click enter for skip step or enter port custom: " port
  read -p "local port is default(1080). click enter for skip step or enter port custom: " localPort
  port=${port:-22} # port default ssh
  localPort=${localPort:-1080} # port default local
  number=$(createNumber) # create a uuid ssh
  SSH="$number| $server|$port|$username|$password|$localPort" # template ssh
  # creating file config
  printf "$SSH \n" | sudo tee -a $pathFile # write config ssh server
  clear # clear terminal
  echo "add ssh $server"
  sleep 1
  getProxy
}

getProxy() {
  clear # clear terminal
  # check exist ssh
  if [[ $(exist_ssh) == 0 ]]; then
    echo "Not Exist SSH. Please Add SSH"
    sleep 3 # sleep 3 s
    addProxy # call method add proxy
  fi
  # read all ssh
  while IFS='|' read -r number server port username password; do
    printf "[%s] %s \n" $number $server
  done <"$pathFile"
  printf "\n"
  read -p "What SSH: " number_ssh

  find_ssh_connect number_ssh
}

createNumber() {
  if [ ! -s $pathFile ]; then
    echo 1
  else
    while IFS='|' read -r number server; do
      echo $((number + 1))
    done <"$pathFile"
  fi
}

exist_ssh(){
  if [ ! -s $pathFile ]; then
    return 0
    else
      return 1
    fi
}

deleteProxy(){
  clear
  if [[ $(exist_ssh) == 0 ]]; then
      echo "Not Exist SSH. Please Add SSH"
      sleep 1.5
      addProxy
      else
        printf "\n Delete SSH \n ----------------------------- \n"
        # read all ssh
          while IFS='|' read -r number server port username password; do
            printf "[%s] %s \n" $number $server
          done <"$pathFile"
          printf "\n"
          read -p "What SSH: " ssh
          find_ssh_delete ssh
  fi
}