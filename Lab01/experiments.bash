#! /bin/bash

#---------------------------------------
# $Author: ee364c21 $
# $Date: 2018-08-28 14:23:41 -0400 (Tue, 28 Aug 2018) $
#---------------------------------------

# Do not modify above this line.

Num_Args=$#
List_of_Args=$@

if      ((Num_Args<1))
then
    echo "Usage: experiments.bash <input 1> [input 2] .. [input N]"
    echo
    exit 1
fi


for (( I=1; I <= $Num_Args;I++ ))
do
    echo "$1:"
    if [ ! -f $1 ];     then
        echo "Filename \"$1\" is not readable."
        echo
        #exit $?
        shift
    else
        exec 4< $1
        shift
        username="random"
        data1=0
        data2=0
        data3=0
        while read username data1 data2 data3 <&4
        do
            let sum=$data1+$data2+$data3
            let avg=$sum/3
            echo "$username $sum $avg"
        done
        echo
    fi
done






