#!/bin/bash

if [ $# -eq 1 ]
then 
	html_file_name=$1
else
	html_file_name='galerie'
fi

#delete all thumbnails and thumbnail directory
rm -Rf ./thumbnails/

#delete html file
rm "./$html_file_name.html"
