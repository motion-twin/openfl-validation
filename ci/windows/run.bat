cd ../../
haxelib run openfl test neko
haxelib run openfl test cpp
haxelib run openfl test android
haxelib run munit test -kill-browser -browser firefox -mlib-log all -result-exit-code


