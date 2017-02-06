#!/bin/bash
pushd uci
rm -rf data
mkdir data
pushd data
for i in `ls ../htmls2`; do
	parenturl=`cat ../htmls2/$i/url.txt`
	mkdir $i
	pushd $i
	for j in `cat ../../htmls2/$i/index.html | grep href=`; do
		if [[ $j =~ ^href=\" ]]; then
			url=${j#href=\"}
			url=${url%%\"*}
			if [[ $url =~ ^[a-zA-Z\.-]+$ ]]; then
				url=$parenturl$url
				wget $url
			fi
		fi
	done
	popd
done
popd
popd

