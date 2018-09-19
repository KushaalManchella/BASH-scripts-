#! /bin/bash

#---------------------------------------
# $Author: ee364c21 $
# $Date: 2018-09-04 15:20:25 -0400 (Tue, 04 Sep 2018) $
#---------------------------------------

# Do not modify above this line.
num_args=$#
filename=$1
if      ((num_args!=1))
then
    echo "Usage: ./UsageStats.bash <filename>"
    exit 1
fi
if      [ ! -e "$filename" ]
then
    echo "Error: $filename does not exist"
    echo
    exit 2
fi
exec 4< $filename
IFS=','
read top time_stamp active_users CPU <&4
echo "Parsing file \"$filename\". Timestamp:$time_stamp"
var=random
echo "Your choices are:"
echo "1) Active user IDs"
echo "2) Highest CPU usage"
echo "3) Top 3 longest running processes"
echo "4) All processes by a specific user"
echo "5) Exit"


tail -n +8 $filename > sort.txt


while [ "$var" != "5" ]
do
    read -p "Please enter your choice: " var
    if [ "$var" == "1" ]
    then
        echo "Total number of active user IDs:$active_users"
        echo 
    elif [ "$var" == "2" ]
    then
        exec 5< sort.txt
        IFS=" " 
        read PID USER PR NI VIRT RES SHR S CPU MEM TIME COMMAND <&5
        echo "User $USER is utilizing the highest CPU resources at $CPU%"
        echo
    elif [ "$var" == "3" ]
    then 
       sort -n -r -k11,11 sort.txt > time_sort.txt 
       head -n 3 time_sort.txt
       echo
    elif [ "$var" == "4" ]
    then
        read -p "Please enter a valid username: " username
        read -p "Please enter a filename to save user's processes: " user_file 
        exec 6< sort.txt
        count=0 
        zero=0
        echo -n > $user_file
        while IFS=" " read PID USER PR NI VIRT RES SHR S CPU MEM TIME COMMAND <&6 
        do 
           if [ "$USER" == "$username" ]
           then
              echo "$read $PID $USER $PR $NI $VIRT $RES $SHR $S $CPU $MEM $TIME $COMMAND" >> $user_file
              let count=count+1 
           fi
       done
       if [ "$count" -gt "0" ]
       then
           echo "Output written to file $user_file"
       else 
           echo "No match found"
       fi
       echo
    fi
done




