#!/usr/bin/env bash

#      _                                       _     _ _     _
#   __| | __ _  ___ _ __ ___   ___  _ __   ___| |__ (_) | __| |
#  / _` |/ _` |/ _ \ '_ ` _ \ / _ \| '_ \ / __| '_ \| | |/ _` |
# | (_| | (_| |  __/ | | | | | (_) | | | | (__| | | | | | (_| |
#  \__,_|\__,_|\___|_| |_| |_|\___/|_| |_|\___|_| |_|_|_|\__,_|
#

# Title:	  Github Fetch Latest (Release)
# Version:	1.0
# Purpose:	Fetches the latest tagged release from a Githib repository

# Usage:
#		  github_fetch_latest.sh [github-repo] [keyword] [output_dir]
#

# Test for parameters being passed to the script
if test -z "$1"; then

    echo "github_fetch_latest.sh [github-repo] [keyword] [output_dir]"
    echo "Eg:"
    echo "github_fetch_latest.sh daemonchild/yaarl amd64 /root"
    echo

# else process the parameters
else

    REPO=$1
    KEYWORD=$2
    OUTPUT_DIR=$3
    SAVE_DIR=$CWD

    #REPO_ARRAY=(${REPO//\// })
    #REPO_USER=${REPO_ARRAY[0]} 
    #REPO_NAME=${REPO_ARRAY[1]}  

    releases_url="https://api.github.com/repos/$REPO/releases/latest"
    echo $releases_url

    repo_url=$(curl -s $releases_url | grep -oP '"url": "\K(.*)(?=")')
    echo $repo_url
    
    fetch_url=$(curl -s $repo_url | grep -oP '"browser_download_url": "\K(.*)(?=")' | grep $KEYWORD)
    echo $fetch_url
    
    cd $OUTPUT_DIR
    wget $fetch_url[0] -q
    cd $SAVE_DIR

fi
