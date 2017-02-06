#!/bin/bash
rm -rf uci
mkdir uci
wget http://archive.ics.uci.edu/ml/datasets.html
mv datasets.html uci
pushd uci
mkdir htmls
pushd htmls
before=""
for i in `cat ../datasets.html | grep href`; do
	if [[ $i =~ ^href=\".* ]]; then
		url=${i#href=\"}
		if [[ $url =~ ^datasets/.* ]]; then
			url=${url%%\"*}
			if [[ $url != $before ]]; then
				before=$url
				url="http://archive.ics.uci.edu/ml/"$url
				wget $url
			fi
		fi
	fi
done
popd
popd

