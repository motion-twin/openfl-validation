#!/bin/bash -x
cd ../../

#create a virtual display on the linux server
sudo Xvfb :10 -screen 0 1024x768x24 -ac 2>xvfb.log &
export DISPLAY=:10
fluxbox &
x11vnc -display :10 -bg -nopw -listen localhost -xkb

#start neko server for collecting JUnit test report over HTTP
if [ $OSTYPE = "cygwin" ]; then
    #windows with cygwin
    neko_server_root="/cygdrive/c/projects/munit/src/"		
else
    #linux
    neko_server_root="build/"
fi

echo "using $neko_server_root as nekotools server root"
rm $neko_server_root/tmp/results.txt

pwd=$(pwd)
cd $neko_server_root
nekotools server >nekotools.log &
SERVER_PID=$!
cd $pwd


export DISPLAY=:10

haxelib run openfl test neko
haxelib run openfl test cpp

#launch android emulator
sudo -H /opt/android-sdk/tools/emulator -avd galaxy_nexus &
ANDROID_EMULATOR=$!
sleep 180

#launch android test 
haxelib run openfl test android &
sleep 60

haxelib run munit test -kill-browser -browser firefox -mlib-log all -result-exit-code

kill -15 $SERVER_PID
kill -15 $ANDROID_EMULATOR

#photo !
sudo ci/linux/image.sh
