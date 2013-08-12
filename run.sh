#!/bin/bash


if [ $OSTYPE = "cygwin" ]; then
	#windows
    neko_server_root="/cygdrive/c/projects/munit/src/"
else
	#linux
	neko_server_root="build/"
fi

echo $neko_server_root

pwd=$(pwd)
cd $neko_server_root
nekotools server 2>nekotools.log &
SERVER_PID=$!
cd $pwd

export DISPLAY=:10

haxelib run openfl test neko
haxelib run openfl test cpp	

haxelib run openfl test android &
sleep 120

haxelib run munit test -kill-browser -browser firefox -mlib-log all -result-exit-code



kill -15 $SERVER_PID
