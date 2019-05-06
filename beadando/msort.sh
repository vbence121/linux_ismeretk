#!/bin/bash
function help () {
		echo "Syntax guide: ./script.sh [from to] [-G] [-M]"
		echo "If one or less location arguments are provided the default ~/Music folder will be used"
		exit 0
}
function move () {
	M="true"
}
function genre () {
	G="true"
}
G=false
from=~/Music
to=~/Music
	case $# in 
		0)
			;;
		1)
	      case $1 in
			-G)
				genre
				;;
			-M)
				move
				;;
			-h | --help | *)
				help
				;;
		  esac
		  ;;
		2) 
			if [[ -d $1 ]] && [[ -d $2 ]]; then
				from=$1
				to=$2
			else if [[ $1 = "-G" ]] && [[ $2 = "-M" ]]; then
					genre
					move
				else
					help
				fi
			fi
			;;	
		3)	
			if [[ -d $1 ]] && [[ -d $2 ]]; then
				from="$1"
				to="$2"
				if [[ $3 = "-G" ]]; then
					genre
				else if [[ $3 = "-M" ]]; then
						move
					else 
						help
					fi
				fi
			else
				help
			fi
			;;
		4)
			if [[ -d $1 ]] && [[ -d $2 ]] && [[ $3 = "-G" ]] && [[ $4 = "-M" ]]; then
				from="$1"
				to="$2"
				genre
				move
			else 
				help
			fi
			;;
		*)
			help
			;;
	esac
for i in "$from"/*.mp3
do
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
	if [[ $M == "true" ]]; then
		 mv "$i" "$moveto"."mp3"
	else 
		 cp "$i" "$moveto"."mp3"
	fi 
done
