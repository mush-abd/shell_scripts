#! /bin/bash

echo "Enter first number"
read number1

echo "Enter second number"
read number2

sum=$(($number1+$number2))
product=$(($number1*$number2))

echo "The sum of $number1 and $number2 is $sum"
echo "The product of $number1 and $number2 is $product."

if [[ $sum -eq $product ]]
then
    echo "Equal"
else
    if [[ $sum -gt $product ]]
    then
        echo "sum is greater, as $sum > $product"
    else
        echo "product is greater, as $product > $sum"
    fi
fi