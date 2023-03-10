#!/bin/bash
# increase/decrease/set/get the backlight brightness (range 0-255)
#

# PCI device on which to operate
DEVICE=00:02.0

# Amount to raise/lower the backlight when called with "up" or "down"
AMOUNT=8

# Minimum backlight value reachable via "down"
MIN=1

# Default backlight level when toggling on
DEFAULT=64

#get current brightness in hex and convert to decimal
var1=`setpci -s $DEVICE F4.B`
var1d=$((0x$var1))
case "$1" in
    up)
        #calculate new brightness
        var2=`echo "ibase=10; obase=16; a=($var1d+$AMOUNT);if (a<255) print a else print 255" | bc`
        echo "$0: increasing brightness from 0x$var1 to 0x$var2"
        setpci -s $DEVICE F4.B=$var2
        ;;
    down)
        #calculate new brightness
        var2=`echo "ibase=10; obase=16; a=($var1d-$AMOUNT);if (a>$MIN) print a else print $MIN" | bc`
        echo "$0: decreasing brightness from 0x$var1 to 0x$var2"
        setpci -s $DEVICE F4.B=$var2
        ;;
    set)
        #n.b. this does allow "set 0" i.e. backlight off
        echo "$0: setting brightness to 0x$2"
        setpci -s $DEVICE F4.B=$2
        ;;
    get)
        echo "$0: current brightness is 0x$var1"
        ;;
    toggle)
        if [ $var1d -eq 0 ] ; then
            echo "toggling up"
            setpci -s $DEVICE F4.B=$DEFAULT
        else
            echo "toggling down"
            setpci -s $DEVICE F4.B=0
        fi
        ;;
    *)
        echo "usage: $0 {up|down|set <val>|get|toggle}"
        ;;
esac
exit 0
