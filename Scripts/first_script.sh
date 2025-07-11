#! /usr/bin/bash

echo "Are you over 18?[Yes/No]"

read response

if [ $response == "Yes" ]
then
    echo "You are allowed"
else
    if [ $response == "No" ]
    then
        echo "Sorry, you are underage"
    else
        echo "Wrong input, sorry"
    fi
fi