#!/bin/bash

# Loop through each directory in REPO_DIR
backIFS=$IFS

BACK=$(pwd)
git pull $SCRIPT_DIR
cd $BACK
while IFS='' read -r REPO_DIR; 
do {
    echo $REPO_DIR;

    if [ -d "$REPO_DIR/.git" ]; 
    then
        echo "Revisando cambios para $REPO_DIR"
        cd "$REPO_DIR" && git pull
    fi
    } &
done < $SCRIPT_DIR/files/git_path.txt;
wait;
IFS=$backIFS;
