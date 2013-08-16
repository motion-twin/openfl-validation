@echo off
CALL start "nekoserver.bat"

cd ../../
haxelib.exe run openfl test neko
haxelib.exe run openfl test cpp
haxelib.exe run openfl test android
haxelib.exe run munit test -kill-browser -browser firefox -mlib-log all -result-exit-code


