
#!/bin/bash
#simple Shellscript for waybar/i3blocks/polybar on Pinebook pro
#05012020 geri123@gmx.net Gerhard S.

PERCENT=$(headsetcontrol -b | grep -Eo '[0-9]{1,3}')
case $((
 $PERCENT >= 0 && $PERCENT <= 20 ? 1 :
 $PERCENT > 20 && $PERCENT <= 40 ? 2 :
 $PERCENT > 40 && $PERCENT <= 60 ? 3 :
 $PERCENT > 6 && $PERCENT <= 80 ? 4 : 5)) in
#
       (1) echo "": $PERCENT%;;
       (2) echo "": $PERCENT%;;
       (3) echo "": $PERCENT%;;
       (4) echo "": $PERCENT%;;
       (5) echo "": $PERCENT%;;
esac


