#! /bin/bash

#---------------------------------------
# $Author: ee364c21 $
# $Date: 2018-09-02 18:17:01 -0400 (Sun, 02 Sep 2018) $
#---------------------------------------

# Do not modify above this line.

cd c-files
for i in *.c
do
    gcc -Wall -Werror -std=c99 $i -o ${i%.c}.o 2>/dev/null
    if [ $? -ne 0 ]
    then
        echo "Compiling file $i... Error: Compilation failed."
    else
        echo "Compiling file $i... Compilation succeeded."
        ./${i%.c}.o > ${i%.c}.out 
    fi
done
