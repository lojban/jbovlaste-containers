#!/bin/bash

if [ ! -f /.dockerenv ]
then
	echo "This needs to be run in docker."
	exit 1
fi

# make_links() {
# 	mkdir js
# 	for file in $(ls /srv/src/*)
# 	do
# 		# This works because by default ln won't overwrite things
# 		ln -s $file
# 	done
# 
# 	cd js
# 	for file in $(ls /srv/src/Glaukaba/js/*)
# 	do
# 		ln -s $file
# 	done
# 	for file in $(ls /srv/src/Glaukaba-JS/*.js /srv/src/Glaukaba-JS/*-template)
# 	do
# 		ln -s $file
# 	done
# }
# 
# cd /srv/site
# make_links
# 
# for dir in jbo en sance ideas
# do
# 	make_links
# done

# FIXME: run the web server
/bin/bash
