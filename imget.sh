IFS=$'\n'
if [ -f dir.txt ]
then
rm dir.txt
fi
for i in $(ls -1 -v *.html)
do
	#echo $i
	g=$(cat $i | grep '<img wid' | cut -d "\"" -f4 | rev | cut -d "/" -f2- | rev | sort -u)
	di=$(echo $g | rev | cut -d "/" -f1 | rev)
	#echo DIR: $di
	if [ ! -d $di ]
	then
	mkdir $di
	cd $di
	cat ../$i | grep '<img wid' | cut -d "\"" -f4 > images.txt
	rm order.txt
	for j in $(cat images.txt)
	do
		wget -c -q --show-progress $j
	done
	cd ..
	else
		echo $di >> dir.txt
	fi
done
for i in $(cat dir.txt)
do
	cd $i
	for j in $(cat images.txt)
        do
                wget -c -q --show-progress $j
        done
	cd ..
done
