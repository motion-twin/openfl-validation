#!/bin/bash -x
if [ $OSTYPE = "cygwin" ]; then
        #windows
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

haxelib run openfl test android &
sleep 60

haxelib run munit test -kill-browser -browser firefox -mlib-log all -result-exit-code

kill -15 $SERVER_PID
