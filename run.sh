#!/bin/sh

#Runs tests on a linux / mac / windows+cygwin.

openfl test neko
openfl test cpp

#connect a device or launch an AVD manually before launching android tests
#openfl test android

#openfl test ios -simlator

#Runs html5 and flash tests in browser.
haxelib run munit test


