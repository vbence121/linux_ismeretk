#!/bin/bash
function fact
{
    f=$((f*$i))
}
f=1
i=2
s=3
while [ $i -le $s ]
do
fact $f
i=$((i+1))
done
echo $f
