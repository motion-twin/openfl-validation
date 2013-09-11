#!/bin/bash -x

#get some diskspace
sudo rm -rf /tmp/android-*

cd ../../

#create a virtual display on the linux server
Xvfb :10 -screen 0 1024x768x24 -ac >xvfb.log 2>&1 &
export DISPLAY=:10
fluxbox &
x11vnc -display :10 -bg -nopw -listen localhost -xkb >x11vnc.log 2>&1

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
rm -rf ./report/test/*

pwd=$(pwd)
cd $neko_server_root
nekotools server >nekotools.log 2>&1 &
SERVER_PID=$!
cd $pwd

haxelib run openfl test neko
haxelib run openfl test cpp

#launch android emulator
sudo -H /opt/android-sdk/tools/emulator-arm -avd nexuss &
ANDROID_PID2=$!
sleep 60

#launch android test (with sudo because the avds are in /root/.android folder)
sudo haxelib run openfl test android -simulator &
ANDROID_PID=$!
sleep 120

haxelib run munit test -kill-browser -browser firefox -mlib-log all -result-exit-code

kill -15 $SERVER_PID
kill -15 $ANDROID_PID
kill -15 $ANDROID_PID2

#photo !
cd $pwd
sudo ./image.sh
