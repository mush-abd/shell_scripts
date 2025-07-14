#! /bin/bash

#==============================
# This script sets up a cron job to fetch weather data
# for a specified city and logs the current and forecasted temperatures
# It creates a file named rx_poc.txt to store the data
#==============================

# First, it creates an empty file named rx_poc.txt
# This file will store the weather data
touch rx_poc.txt
echo "year\tmonth\tdat\ttobs_temp\tfc_temp" > rx_poc.txt

# It then writes a header line to the file
# The header includes the fields: year, month, date, tobs_temp, and fc
echo -e "year\tmonth\tdat\ttobs_temp\tfc_temp" > rx_poc.txt

# Finally, it creates an empty script file named rx_poc.sh
touch rx_poc.sh
echo "#! /bin/bash" > rx_poc.sh

# It also makes the script executable
chmod u+x rx_poc.sh

# This script fetches the weather report for a specified city
city=Aligarh

curl -s wttr.in/$city?T --output weather_report


# To extract the current temperature
obs_temp=$(curl -s "wttr.in/$city?T" | grep -m 1 '°.' | grep -Eo -e '-?[[:digit:]]+°[CF]')
echo "The current Temperature of $city: $obs_temp"


# To extract the forecast temperature for noon tomorrow
fc_temp=$(curl -s "wttr.in/$city?T" | head -23 | tail -1 | grep '°.' | cut -d 'C' -f2 | grep -Eo -e '-?[[:digit:]].*')
echo "The forecasted temperature for noon tomorrow for $city : $fc_temp C"

#Assign Country and City to variable TZ
TZ='India/Aligarh '

# Use command substitution to store the current day, month, and year in corresponding shell variables:
day=$(TZ='India/Aligarh' date -u +%d) 
month=$(TZ='India/Aligarh' date +%m)
year=$(TZ='India/Aligarh' date +%Y)


echo -e "$year\t$month\t$day\t$obs_temp\t$fc_temp" >> rx_poc.txt


job="30 2 * * * /home/project/rx_poc.sh"

# Check if job already exists
crontab -l 2>/dev/null | grep -F "$job" > /dev/null

if [ $? -eq 0 ]; then
    echo "Cron job already exists"
else
    (crontab -l 2>/dev/null; echo "$job") | crontab -
    echo "Cron job added successfully"
fi

# Create a file to store historical forecast accuracy
echo -e "year\tmonth\tday\tobs_temp\tfc_temp\taccuracy\taccuracy_range" > historical_fc_accuracy.tsv