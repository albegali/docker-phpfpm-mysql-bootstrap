#!/bin/bash

PROJECT_NAME=""
while [[ -z "$PROJECT_NAME" ]]; do
    read -p "Enter valid Project name: " PROJECT_NAME
done

HOST_FOLDER=""
while [[ -z "$HOST_FOLDER" ]]; do
    HOST_FOLDER_DEFAULT="/var/www/$PROJECT_NAME"
    read -p "Enter valid host folder name[$HOST_FOLDER_DEFAULT]: " HOST_FOLDER
    HOST_FOLDER=${HOST_FOLDER:-$HOST_FOLDER_DEFAULT}

    if [ ! -d "$HOST_FOLDER" ]; then
        echo "The folder doesn't exist on your host"
        HOST_FOLDER=""
    fi
done

INDEX_FOLDER_OK=""
while [[ -z "$INDEX_FOLDER_OK" ]]; do
    INDEX_FOLDER_OK="ok"

    read -p "Enter valid index file folder name or leave blank if in root: " INDEX_FOLDER

    INDEX_FOLDER_FULL="$HOST_FOLDER/$INDEX_FOLDER"
    if [ ! -d "$INDEX_FOLDER_FULL" ]; then
        echo "The folder doesn't exist on your host"
        INDEX_FOLDER=""
        INDEX_FOLDER_OK=""
    fi
done

INDEX_FILE=""
INDEX_FILE_FULL=""
while [[ -z "$INDEX_FILE" ]]; do
    INDEX_FILE_DEFAULT="app_dev.php"
    read -p "Enter valid index file name[$INDEX_FILE_DEFAULT]: " INDEX_FILE
    INDEX_FILE=${INDEX_FILE:-$INDEX_FILE_DEFAULT}

    if [[ -z "$INDEX_FOLDER" ]]; then
        INDEX_FILE_FULL="$HOST_FOLDER/$INDEX_FILE"
    else
        INDEX_FILE_FULL="$HOST_FOLDER/$INDEX_FOLDER/$INDEX_FILE"
    fi

    if [ ! -e "$INDEX_FILE_FULL" ]; then
        echo "The file $INDEX_FILE_FULL doesn't exist on your host"
        INDEX_FILE=""
    fi
done

HOST_NAME=""
while [[ -z "$HOST_NAME" ]]; do
    HOST_NAME_DEFAULT="$PROJECT_NAME.com"
    read -p "Enter valid host name[$HOST_NAME_DEFAULT]: " HOST_NAME
    HOST_NAME=${HOST_NAME:-$HOST_NAME_DEFAULT}
done

echo "Project Name: $PROJECT_NAME"
echo "Host name: $HOST_NAME"
echo "Index file: $INDEX_FILE_FULL"

#OLD="xyz"
#NEW="abc"
#DPATH="/home/you/foo/*.txt"
#BPATH="/home/you/bakup/foo"
#TFILE="/tmp/out.tmp.$$"
#[ ! -d $BPATH ] && mkdir -p $BPATH || :
#for f in $DPATH
#do
#  if [ -f $f -a -r $f ]; then
#    /bin/cp -f $f $BPATH
#   sed "s/$OLD/$NEW/g" "$f" > $TFILE && mv $TFILE "$f"
#  else
#   echo "Error: Cannot read $f"
#  fi
#done
#/bin/rm $TFILE