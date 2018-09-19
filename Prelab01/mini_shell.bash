#! /bin/bash

#---------------------------------------
# $Author: ee364c21 $
# $Date: 2018-08-26 15:02:05 -0400 (Sun, 26 Aug 2018) $
#---------------------------------------

# Do not modify above this line.
var="random"
CWD="$(pwd)"
while [ "$var" != "quit" ]
do
    read -p "Enter a command: " var
    if [ "$var" == "hello" ]
    then
        echo "Hello $USER"
    elif [ "$var" == "compile" ]
    then
        for i in *.c; do
            gcc -Wall -Werror -std=c99 $i -o ${i%.c}.o
            if [ $? -ne 0 ]
            then
                echo "Compilation failed for: $i"
            else 
                echo "Compilation succeeded for: $i"
            fi
        done
    elif [ "$var" == "run" ]
    then
        read -p "Enter filename: " filename
        read -p "Enter arguments: " args
        if [ ! -e "$CWD/$filename" ]
        then
            echo "Invalid filename"
        else
            ./$filename $args
        fi
    elif [ "$var" == "quit" ]
    then
        echo "Goodbye"
    else
        echo "Error: unrecognized input"
    fi
    echo  
done


