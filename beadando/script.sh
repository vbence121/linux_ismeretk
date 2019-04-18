#!/bin/bash

	case $# in 
		1)
		    from=~/Music
		    to=~/Music
	          case $1 in 
			-G)
				G="true"
				;;
			-h | --help | *)
				echo "Syntax guide: ./script.sh [from] [to] [-G]"
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
base=$from
for i in "$from"/*.mp3
do
    echo $from $to
    from=$base
    echo $base $from
    if [ "$G" != "true" ]; then
 	genre=`ffprobe "$i" 2>&1 | grep -w "genre" | cut -c 23-`
	if [[ -d "$to"/"$genre" ]]; then
	mkdir "$to"/"$genre"
	to="$to"/"$genre"
	fi
   fi
	echo $i
	Artist=`ffprobe "$i" 2>&1 | grep -w "artist" | cut -c 23-`
	echo "$Artist"
	mkdir "$to"/"$Artist" 2> /dev/null
	Album=`ffprobe "$i" 2>&1 | grep  -w "album" | cut -c 23-`
	echo "$Album"
	mkdir "$to"/"$Artist"/"$Album" 2> /dev/null
	Title=`ffprobe "$i" 2>&1 | grep -w  "Title"  | cut -c 23-`
	echo "$Title"
	cp "$i" "$to"/"$Artist"/"$Album"/"$Title"
done
