#!/bin/bash
# Download a specific folder from a github repo:
# ./gitget.sh https://github.com/TheMuppets/proprietary_vendor_samsung/tree/lineage-17.0/klte
# afaneh92 @ xda-developers

dpkg -l "subversion" &> /dev/null; [ $? = '1' ] && { echo "svn not installed, installing now."; sudo apt-get install subversion; }

case $1 in
  "") echo "usage: ./gitget.sh https://github.com/TheMuppets/proprietary_vendor_samsung/tree/lineage-17.0/klte"; exit 1;
esac;

# Clear the console before starting
  clear

# Location
  export DIR=`readlink -f .`;

re="^(https|git)(:\/\/|@)([^\/:]+)[\/:]([^\/:]+)\/(.+)\/(.+)\/(.+)\/(.+)$"

if [[ $1 =~ $re ]]; then    
    protocol=${BASH_REMATCH[1]}
    separator=${BASH_REMATCH[2]}
    hostname=${BASH_REMATCH[3]}
    user=${BASH_REMATCH[4]}
    project=${BASH_REMATCH[5]}
    tree=${BASH_REMATCH[6]}
    branch=${BASH_REMATCH[7]}
    folder=${BASH_REMATCH[8]}

    path=${project//_/\/}/$folder

    if [[ -d $DIR/$path ]]; then
        rm -rf $DIR/$path
    fi

    arg=${1//tree/branches}
    svn export $arg $path
fi

exit 0;
