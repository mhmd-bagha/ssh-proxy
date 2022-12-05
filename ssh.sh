connect(){
  printf "\n ------------------------------------- \n Wait for Connect To SSH... \n ------------------------------------- \n"
   sshpass -p $password ssh -D $local_port -N $username@$server -p $port # connect to ssh
}

find_ssh_connect(){
  get_ssh=$( ! grep -w "$number_ssh|" $pathFile)
  if $get_ssh
  then
clear
echo "SSH Does Not Exist!!!" # message not exist
sleep 1s # sleep for step next
getProxy # get all proxy
else
  clear
      IFS='|'
      read -ra data_ssh <<< "$get_ssh"
      local_port="${data_ssh[5]}"
      local_port="${local_port//[[:blank:]]/}" # remove space
      username="${data_ssh[3]}"
      username="${username//[[:blank:]]/}" # remove space
      server="${data_ssh[1]}"
      server="${server//[[:blank:]]/}" # remove space
      port="${data_ssh[2]}"
      port="${port//[[:blank:]]/}" # remove space
      password="${data_ssh[4]}"
      connect $local_port $username $server $port $password
    fi
}

find_ssh_delete(){
  getSsh=$( grep -w "$ssh|" $pathFile)
    if [[ $getSsh ]];
    then
      clear
      IFS='|'
      read -ra data_ssh <<< "$getSsh"
      server="${data_ssh[1]}"
      username="${data_ssh[3]}"
      echo "--------------------------------"
      printf "\n Server: %s   Username: %s \n \n" $server $username
      echo "--------------------------------"
      read -p ":: Are You Sure Delete? [y/n] " yno
      case $yno in
      "y"|"yes") sudo sed -i "s/$getSsh//g" $pathFile
      sudo sed -i '/^[[:space:]]*$/d' $pathFile
       echo ":: Deleted successful $server"
       sleep 1.5
       start ;;
      "n"|"no") deleteProxy ;;
    *) printf "\n`basename ${0}`: usage: [-n no] | [-y yse] for delete SSH"
      exit 1 ;;
      esac
  else
    clear
    echo "SSH Does Not Exist!!!" # message not exist
    sleep 1s # sleep for step next
    deleteProxy # get all proxy
      fi
}