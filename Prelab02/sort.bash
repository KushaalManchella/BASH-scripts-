#! /bin/bash

#---------------------------------------
# $Author: ee364c21 $
# $Date: 2018-09-02 18:15:19 -0400 (Sun, 02 Sep 2018) $
#---------------------------------------

# Do not modify above this line.

Num_Args=$#
Filename=$1
if      ((Num_Args!=1))
then
    echo "Usage: ./sort.bash <filename>"
    echo
    exit 1
fi
if      [ ! -e "$Filename" ]
then
    echo "Error: $Filename does not exist."
    echo
    exit 2
fi
#sort -t',' -n -r -k5 $Filename
IFS=$'\n'
sorted_array=( $(sort -t',' -n -k5 $Filename) )
echo "The 5 fastest CPUs:"
for ((I = 0; I < 5; I++))
do
    echo  ${sorted_array[$I]}
done 
echo
sorted_array=( $(sort -t',' -n -k4 $Filename) )
echo "The 3 most efficient CPUs:"
for ((I = 0; I < 3; I++))
do
    echo ${sorted_array[$I]}
done 
echo


sort -t',' -n -k2,2 -k5,5 $Filename > cache.txt
exec 4< cache.txt
counter=0
lower_bound=0
cache=4
while IFS=',' read processor_name cache_size issue_width CPI execution_time <&4
do
    if  [ "$cache_size" == "$cache" ]
    then
        let counter+=1
    fi
    if [ "$cache_size" -lt "$cache" ]
    then
        let lower_bound+=1
    fi
done
        
let upper_bound=lower_bound+counter
let difference=upper_bound-lower_bound

echo "The CPUs with cache size 4:"
head -n $upper_bound cache.txt | tail -n $difference
echo

sort -t',' -n -r -k5,5 $Filename > slowest.txt
exec 4< slowest.txt

counter=0
read -p "Enter a value for n: " n
echo "The $n fastest CPUS:"
lower_bound=0
let upper_bound=$n+$lower_bound
let difference=upper_bound-lower_bound
head -n $upper_bound slowest.txt | tail -n $difference
echo

sort -t',' -k1,1 -k4,4 $Filename > sorted_CPI.txt




