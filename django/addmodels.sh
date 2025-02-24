#!/usr/bin/env bash

#Version v1.0
TEMP_FILE=".temp" # TEMP FILE TO STORE THE MODELS NAMES

if [ "$1" == "-h" ]; then # CALL THE HELP TO EXPLAIN HOW TO USE THE SCRIPT
    echo "This script will add the models to the admin view"
    echo "Example:"
    echo "          bash .addmodels.sh project_name app_name"
fi
if [ "$1" == "" ]; then
    echo "USE THE PARAMETER -h TO DISPLAY HELP"

else 
    if [ -d $1 ]; then #CHECK IF THE PROJECT EXIST
        cd $1
        if [ -d "apps/$2" ]; then # CHECK IF THE APP EXISTS
            cd apps/$2
            echo "@$(date)" >> .admin.py.old # ADD THE DATE TO THE BACKUP FILE
            cat admin.py >> .admin.py.old # BACKUP THE ADMIN.PY FILE
            echo "%" >> .admin.py.old 
            echo "Adding models from $2 to the admin view"

            echo 'from django.contrib import admin' > admin.py # CREATE OR CLEAN THE ADMIN.PY FILE with the import of admin
            cat models.py | grep '^class .*(models.Model):' | cut -d ' ' -f 2 |cut -d '(' -f 1 >> $TEMP_FILE # GET THE MODELS NAMES

            # ADD THE IMPORTS TO THE ADMIN.PY

            cat $TEMP_FILE| while read line; do # LOOP THE MODELS NAMES TO ADD THE IMPORTS TO THE ADMIN.PY
                echo "$line imported" # PRINT THE MODEL NAME
                echo "from .models import $line" >> admin.py;
            done

            echo "" >> admin.py # ADD A BLANK LINE
            echo "# Register your models here." >> admin.py # ADD A COMMENT
            echo "" >> admin.py # ADD A BLANK LINE

            # CREATE THE ADMIN MODELS 

            cat $TEMP_FILE | # GET THE MODELS NAMES 
            while read line; do # LOOP THE MODELS NAMES TO CREATE THE ADMIN MODEL
                
                echo "class ${line}Admin(admin.ModelAdmin):" >> admin.py; # CREATE THE ADMIN MODEL
                echo "    pass" >> admin.py; # Make the pass
                echo "" >> admin.py; # ADD A BLANK LINE
            done

            # REGISTER THE MODELS TO THE ADMIN.PY

            cat $TEMP_FILE | # GET THE MODELS NAMES 
            while read line; do # LOOP THE MODELS NAMES TO ADD THE REGISTER TO THE ADMIN.PY
                echo "$line registered" # PRINT THE MODEL NAME
                echo "admin.site.register($line, ${line}Admin)" >> admin.py;
            done
        fi
    fi
fi
if [ -f $TEMP_FILE ]; then # REMOVE THE TEMP FILE
    rm $TEMP_FILE
fi



#dahguidsfguisdfnbjusduvhuid

#bjkfdsvhdfsuihudhgudsfhu