#!/bin/bash
G=false
from=~/Music
to=~/Music
	case $# in 
		0)
			;;
		1)
	          case $1 in
			-G)
				G="true"
				;;
			-h | --help | *)
				echo "Syntax guide: ./script.sh [from to] [-G]"
				echo "If one or less location arguments are provided the default ~/Music folder will be used"
				exit 0
				;;
		  esac
		  ;;
		2) 
			if [[ -d $1 ]] && [[ -d $2 ]]; then
				from=$1
				to=$2
			else 
				./$0 -h
				exit 0
			fi
			;;	
		3)	
			if [[ -d $1 ]] && [[ -d $2 ]] && [[ $3 = "-G" ]]; then
				from="$1"
				to="$2"/
				G="true"
			else
				./$0 -h
				exit 0
			fi
			;;
		4 | *)
				./$0 -h
				exit 0
			;;
	esac
basef=$from
baset=$to
for i in "$from"/*.mp3
do
    from=$basef
    to=$baset
    echo -e "\nfrom: "$i
#GENRE
    if [[ $G == "true" ]]; then
 	genre=`ffprobe "$i" 2>&1 | grep -w "genre" | cut -c 23-`
	if [[ $genre == "" ]]; then
		echo "A 'genre' mezo nincs kitoltve az adott fileban!"
	else
	mkdir "$to"/"$genre" 2> /dev/null
	to="$to"/"$genre"
	fi
   fi
#ARTIST
	artist=`ffprobe "$i" 2>&1 | grep -w "artist" | cut -c 23-`
	if [[ $artist == "" ]]; then
		echo "Az 'artist' mezo nincs kitoltve az adott fileban!"
	else
		echo "$artist"
		mkdir "$to"/"$artist" 2> /dev/null
	fi
#ALBUM
	album=`ffprobe "$i" 2>&1 | grep  -w "album" | cut -c 23-`
	if [[ $album == "" ]]; then
		echo "Az 'album' mezo nincs kitoltve az adott fileban!"
	else
		echo "$album"
		mkdir "$to"/"$artist"/"$album" 2> /dev/null
	fi
#TITLE
	title=`ffprobe "$i" 2>&1 | grep -w  "title"  | cut -c 23-`
	if [[ $title == "" ]]; then
		echo "A 'title' mezo nincs kitoltve az adott fileban!"
	else
		echo "$title"
	fi
#CP/MV
	moveto="$to"/"$artist"/"$album"/"$title"
	echo "to: " $moveto
	cp "$i" "$moveto"."mp3"
done
