#! /bin/bash

#----------------------------------
# $Author: ee364c21 $
# $Date: 2018-09-04 15:16:30 -0400 (Tue, 04 Sep 2018) $
#----------------------------------

function part_1 
{               
    filename="people.csv"
    tail -n +2 $filename | sort -t',' -k4,4 -k6,6 -k1,1 -k2,2 > sorted.txt 
    tail -n 5 sorted.txt 
    echo
    return                      
}                               

function part_2
{              
    cd src
    for i in *.c 
    do 
        gcc -Wall -Werror -std=c99 $i -o ${i%.c}.o 2>/dev/null 
        if [ $? -ne 0 ]
        then 
            echo "Compilation failed for: \"$i\""
        else 
            echo "Compilation succeeded for: \"$i\""
        fi
    done
    return                     
}                              


# To test your function, you can call it below like this:
#
 part_1
 part_2
