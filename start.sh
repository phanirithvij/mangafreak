IFS=$'\n'
link=$1
if [ $# -ne 1 ]
then
	echo Enter link from mangafreak.com
	read link
fi
if [[ $link == *"mangafreak.com/manga/"* ]]
then
	link=$link
	di=$(echo $link | rev | cut -d "/" -f1 | rev)
else
	di=$link
	h='mangafreak.com/manga/'
	link=$h$link
fi
p=1
echo ' ' > ch.txt
for i in {1..5}
do
	wget -O ch.html -q $link/$p
	cat ch.html | grep '<a  class="ch' >> ch.txt
	p=$((p+1))
done
	cat ch.txt | sort | uniq > h.temp
	mv h.temp ch.txt
if [ ! -d $di ]
then
	mkdir $di
fi
chmod 777 *.sh
cp testforall.sh imget.sh $di/
mv ch.txt $di/
cd $di
for i in $(cat ch.txt)
do
	n=$(echo $i | cut -d "\"" -f4)
	s=$(echo $n | rev | cut -d "/" -f1 | rev)
	wget -c -O $s.html -q --show-progress $n/full
done
if [ -f ' .html' ]
then
rm ' .html'
fi
cd ..
