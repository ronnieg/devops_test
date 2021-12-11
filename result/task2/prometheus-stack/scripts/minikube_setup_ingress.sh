#/bin/bash
set -o pipefail

hostsPath="/etc/hosts"
minikubeIP=$(minikube -p aged ip)

function help() {
    echo ""
    echo "USAGE:"
    echo ""
    echo "  sh $0 [postsync|postuninstall] Args"
    echo ""
    echo "EXAMPLE:"
    echo ""
    echo " sh $0 postsync prometheus.local alertmanager.local grafana.local"
    echo ""
    exit 1
}

function showFile() {
    echo "INFO: ${hostsPath} contents:"
    cat ${hostsPath}
}

function hosts_records_add() {

   # assuming 2nd arg won't change
   pattern=$(echo "${hostList}" | awk '{print $1 " " $2}')
   
   echo "INFO: Adding/Updating hosts records. Root password required..."
   
   hosts_records_delete ${pattern}
   echo -n "${hostList}" | sudo tee -a ${hostsPath}
   #showFile

}

function hosts_records_delete() {
  local pattern=$@
  echo "INFO: Deleting hosts records. Root password required..."  
  sudo sed -i.bak -e "/${pattern}.*/d" -e "/^$/d" ${hostsPath} 
  #showFile
}

if [ -z ${minikubeIP} ]; then
  echo "ERROR: minikube ip cannot be located, tried: \"\$ minikube ip\". Exiting!"
  exit 1
else 
  echo "INFO: Located minikube ip: ${minikubeIP}"
fi

# check if passed more than 1 parameter
if [ $# -lt 2 ]; then
  echo "ERROR: Invalid number of parameters. Provided: \"$*\". Exiting!"
  help
fi

# start from 2nd arg+
hostList="${minikubeIP} ${@:2}"

echo "INFO: Formed list: ${hostList}"

case $1 in
postsync)
  hosts_records_add
  ;;
postuninstall)
  hosts_records_delete ${hostList}
  ;;
*)
  echo "ERROR: Command not understood: $1. Exiting!"
  exit 1
  ;;
esac