#!/bin/bash

# Directory containing the git repositories
DATE=$(date)
backIFS=$IFS
echo "Committing changes in all git repositories"

while IFS='' read -r REPO_DIR; 
do {
    echo $REPO_DIR;
    if [ -d "$REPO_DIR/.git" ]; 
    then
        cd "$REPO_DIR";
        echo `git add .`;
        
        echo "Committing changes in $REPO_DIR";
        
        git commit -m "Auto commit generated by git_commit_all.sh ${DATE}" ;
        # echo "Auto commit generated by git_commit_all.sh ${DATE}"
    fi
} &
done < $SCRIPT_DIR/files/git_path.txt;
wait;
IFS=$backIFS;