#!/bin/sh

#Runs tests on a linux / mac / windows+cygwin.

openfl test neko
openfl test cpp
#openfl test android

#runs html5 and flash tests in browser
haxelib run munit test


