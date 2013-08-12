file_name=$1
if [ $# -eq 0 ]; then
	file_name="image"
fi

xwd -display :10 -root -out image.xwd
convert image.xwd ${file_name}.png
