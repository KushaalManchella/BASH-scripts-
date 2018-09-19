#! /bin/bash

#---------------------------------------
# $Author: ee364c21 $
# $Date: 2018-08-26 15:12:49 -0400 (Sun, 26 Aug 2018) $
#---------------------------------------

# Do not modify above this line.

Num_Of_Args=$#
Name_Of_Data_File=$1
Name_Of_Olympic_Sport=$2
if      (($Num_Of_Args!=2))
then    
    echo "Usage: ./collect_stats.bash <file> <sport>"
    echo 
    exit 1
fi

if [ ! -f $Name_Of_Data_File ]; then
    echo "Error: $Name_Of_Data_File does not exist."
    echo
    exit 2
fi

exec 4< $Name_Of_Data_File
contestant_count=0
medal_count=0
most_medals=0
IFS=','
while read name sport medals <&4
do
    if    [ "$sport" == "$Name_Of_Olympic_Sport" ]
    then
      let contestant_count++
      let medal_count+=medals
      if (("$most_medals" < "$medals"))
      then
          let most_medals=$medals
          most_medal_name=($name)
      fi
    fi
done

echo "Total contestants: $contestant_count"
echo "Total medals won: $medal_count"
echo "$most_medal_name won the most medals: $most_medals"
echo

