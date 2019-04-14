#!/bin/bash
for i in ~/Music/*.mp3
do
	echo $i
	Artist=`ffprobe "$i" 2>&1 | grep -w "artist" | cut -c 23-`
	echo $Artist
	mkdir ~/Music/"$Artist" 2> /dev/null
	Album=`ffprobe "$i" 2>&1 | grep  -w "album" | cut -c 23-`
	echo $Album
	mkdir ~/Music/"$Artist"/"$Album" 2> /dev/null
	Title=`ffprobe "$i" 2>&1 | grep -w  "Title"  | cut -c 23-`
	echo $Title
	cp "$i" ~/Music/"$Artist"/"$Album"/"$Title"
done
