db=$2
f=$3
echo $2
while [ $db -le $1 ]
do 
	if [[ $2 != 1 ]]
	then
		echo $db
		f=$[$f * $db]
		db=$[$db + 1]
		~/faktorR.sh $1 $db $f
	else	
		db=2
		f=1
		~/faktorR.sh $1 $db $f
	fi
done
