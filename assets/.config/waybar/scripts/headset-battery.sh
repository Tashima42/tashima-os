
#!/bin/bash
#simple Shellscript for waybar/i3blocks/polybar to show corsair headset batterie
#pedrotashima@protonmail.com Pedro Tashima

PERCENT=$(headsetcontrol -b | grep -Eo '[0-9]{1,3}')
case $((
 $PERCENT >= 0 && $PERCENT <= 20 ? 1 :
 $PERCENT > 20 && $PERCENT <= 30 ? 2 :
 $PERCENT > 40 && $PERCENT <= 50 ? 3 :
 $PERCENT > 60 && $PERCENT <= 70 ? 4 :
 $PERCENT > 70 && $PERCENT <= 80 ? 5 :
 $PERCENT > 80 && $PERCENT <= 90 ? 6 : 7)) in
#
       (1) echo "☐" $PERCENT%;;
       (2) echo "⚀" $PERCENT%;;
       (3) echo "⚁" $PERCENT%;;
       (4) echo "⚂" $PERCENT%;;
       (5) echo "⚃" $PERCENT%;;
       (6) echo "⚄" $PERCENT%;;
       (7) echo "⚅" $PERCENT%;;
esac


