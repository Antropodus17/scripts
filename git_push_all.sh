#!/bin/bash

#FOR BETTER PERFORMANCE WE CHANGE THE AUT SOCKET OF SSH TO THE LOCAL

SSH_AUTH_SOCK=$SSH_AUTH_SOCK_OLD

# Loop through each directory in REPO_DIR
backIFS=$IFS

git pull $SCRIPT_DIR

while IFS='' read -r REPO_DIR; do
    echo $REPO_DIR
    if [ -d "$REPO_DIR/.git" ]; then
        echo "Enviando cambios en $REPO_DIR"
        cd "$REPO_DIR" && git push
    fi

done <$SCRIPT_DIR/files/git_path.txt
wait
IFS=$backIFS
