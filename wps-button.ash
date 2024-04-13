#!/usr/bin/ash
. /root/config.ash

#do a http request with the api key, ip and time variable from the config file
HTTP_RESPONSE=$(curl -X GET "http://$PIHOLE_IP/admin/api.php?disable=$DISABLE_TIME&auth=$API_KEY")

#pihole will give out {"status":"disabled"} in json if the request was successful.
if [ $HTTP_RESPONSE = '{"status":"disabled"}' ]
then
        #if the response was sucessful, the WPS LED light will blink 2 times
        echo "255" > /sys/devices/platform/leds/leds/green:wps/brightness
        sleep 1  
        echo "0" > /sys/devices/platform/leds/leds/green:wps/brightness
	sleep 1
	echo "255" > /sys/devices/platform/leds/leds/green:wps/brightness
        sleep 1  
        echo "0" > /sys/devices/platform/leds/leds/green:wps/brightness
	
else
        #if the response failed, the orange Internet LED will blink 2 times
        echo "255" > /sys/devices/platform/leds/leds/orange:wan/brightness
        sleep 1
        echo "0" > /sys/devices/platform/leds/leds/orange:wan/brightness
	sleep 1
	echo "255" > /sys/devices/platform/leds/leds/orange:wan/brightness
        sleep 1  
        echo "0" > /sys/devices/platform/leds/leds/orange:wan/brightness

fi
