#!/bin/bash

pwd=$(pwd)
cd build/
nekotools server 2>nekotools.log &
SERVER_PID=$!
cd $pwd

haxelib run openfl test neko
#haxelib run openfl test cpp	
haxelib run munit test -kill-browser true -browser firefox

kill -15 $SERVER_PID
