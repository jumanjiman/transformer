# Settings > Security > Unknown Sources
# Settings > Developer Options > USB Debugging

partition=$(adb shell 'mount' | awk '/\/system/{print $1}')
adb push debugfs /data/local/
adb push su /data/local/
adb push debugfsinput /data/local/
adb shell mv /data/local/tmp /data/local/tmp.bak
adb shell ln -s $partition /data/local/tmp
adb reboot
sleep 120
adb shell chmod 777 /data/local/debugfs
adb shell "/data/local/debugfs -w $partition < /data/local/debugfsinput"
adb shell rm /data/local/tmp
adb shell mv /data/local/tmp.bak /data/local/tmp
adb shell rm /data/local/su
adb shell rm /data/local/debugfs
adb shell rm /data/local/debugfsinput
adb reboot
sleep 120
adb install Superuser.apk
