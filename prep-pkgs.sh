#!/bin/bash

deploy=/tmp/deploy
mkdir $deploy

mkdir /var/www/html/anvils/app;
setfacl -R -m d:o:rwx /var/www/html/anvils/app
setfacl -R -m o:rwx /var/www/html/anvils/app

for repo in ci stable release;do

	repodir=/var/lib/rundeck/packages/$repo
	mkdir -p $repodir
	
	for v in 1.{0.{0,1},1.{1,2},2.0};do
		reldir=$repodir/v$v/
		mkdir -p $reldir
		for c in web app db;do
			echo "<h2>component=$c version=$v release=$repo</h2>" > $deploy/index.html
			cd $deploy; tar cpzf $reldir/$c-$v.tgz .
		done
	done

done
