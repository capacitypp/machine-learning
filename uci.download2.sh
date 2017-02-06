#!/bin/bash
pushd uci
rm -rf htmls2
mkdir htmls2
pushd htmls2
for i in `ls ../htmls`; do
	#for j in `cat ../htmls/$i | grep href=\"../machine-learning-databases/`; do
	for j in `cat ../htmls/$i | grep Download`; do
		if [[ $j =~ href=.* ]]; then
			url=${j#href=\"}
			url=${url%\"*}
			if [[ $url =~ .*/$ ]]; then
				if [[ $url =~ ^\.\./ ]]; then
					url=${url#../}
					url="http://archive.ics.uci.edu/ml/"$url
				fi
				wget $url
				mkdir $i
				mv index.html $i
				echo $url > $i/url.txt
			fi
		fi
	done
done
popd
popd

