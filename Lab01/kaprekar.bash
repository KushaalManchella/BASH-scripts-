#! /bin/bash

#---------------------------------------
# $Author: ee364c21 $
# $Date: 2018-08-28 15:30:59 -0400 (Tue, 28 Aug 2018) $
#---------------------------------------

# Do not modify above this line.


Num_Args=$#

if (($Num_Args!=1))
then
    echo "Usage: kaprekar.bash <non-negative integer>"
fi
NN_integer=$1
if ((NN_integer<0))
then
    echo "Usage: karpekar.bash <non-negative integer>"
fi



for ((I=1; I <= NN_integer; I++))
do
   # echo "I = $I"
    let square=I*I
  #  echo "Square = $square"
    num_digits=$(echo -n $square | wc -c)
    if (($I==1))
    then
        echo "$I, square=$square, $square+0=$square"
 #   elif (($I==9))
 #   then
 #       echo "$I, square=$square, $square+0=$square"
    elif        (($num_digits>1))
    then
        if      (($num_digits%2==0))
        then 
            let separator=num_digits/2
        else
            let separator=num_digits-1
            let separator=separator/2
        fi
        let separator_increment=separator+1

     #   echo "separator = $separator"
        num1=$(echo -n "$square" | cut -c 1-$separator)
        num2=$(echo -n "$square" | cut -c $separator_increment-$num_digits)
        let f1=$((10#$num1))
        let f2=$((10#$num2))
        let sum=f1+f2
     #   echo "$num1+$num2=$sum"

        if (($sum==$I))
        then
            echo "$I, square=$square, $num2+$num1=$sum"
        fi
    fi
done
echo

