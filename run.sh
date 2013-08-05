#!/bin/bash -x

pwd=$(pwd)
cd /cygdrive/c/projects/munit/src
nekotools server &
SERVER_PID=$!
cd $pwd

haxelib run openfl test neko
#haxelib run openfl test cpp
haxelib run munit test

kill -15 $SERVER_PID