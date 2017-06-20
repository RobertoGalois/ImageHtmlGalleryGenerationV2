#!/bin/bash

#listing all files image
file=`ls | grep -E '.\.(jpg|jpeg|png|bmp|gif)'`


mkdir thumbnails

#each file jpg listed is copied in a thumbnail
for file_name in $file
do
	`convert -thumbnail x200 ./$file_name ./thumbnails/thumb.$file_name`
done

#definition of the name of the html file
if [ $# -eq 1 ] 
then 
	html_file_name=$1
else
	html_file_name='galerie'
fi

#generate the head of the html file
echo -e '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" >
  <head>
    <title>Ma galerie</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <style type="text/css">
      a img.lightBox
      { 
        border:0;
        height: 200px;
      }
      div#overlay
      {
        display:none;
        position: absolute;
        top: 0px;
        left: 0px;
        width: 100%;
        height: 100%;
        text-align: center;
        background-color: rgba(0,0,0,0.6);
      }
    </style>
  </head>
  <body>
    <div id="overlay"></div>
    <p>' > "./$html_file_name.html"

#include all jpg in galerie.html
for file_name in $file
do 
	echo "      <a href=\"./$file_name\" class=\"lightBox\"><img src=\"./thumbnails/thumb.$file_name\" alt=\"\" /></a>" >> "./$html_file_name.html"
done

#generate the tail of the html file width the rudimentary lightbox
echo "    </p>

<script>
(function () {

	var tabLiens = window.document.querySelectorAll('a.lightBox');
	var lTabLiens = tabLiens.length;
	var overlay = window.document.getElementById('overlay');
	var displayed = false;
	var stockImg = new Image();

	var evenement = {

		clickLien: function (e) {
			e.preventDefault();
			evenement.displayImg(e.currentTarget);
		},

		displayImg: function (element) {

			stockImg.addEventListener('load', function () {
				overlay.innerHTML = '';
				overlay.appendChild(stockImg);
				overlay.focus();
				displayed = true;
			});

			stockImg.src = element.href;
			overlay.style.display = 'block';
			overlay.innerHTML = '<span>Chargement en cours...</span>';
		},

		overlayClick: function (e) {
			evenement.unDisplayImg();
		},

		overlayKey: function (e){
			if(displayed && (e.keyCode==27))
				evenement.unDisplayImg();
		},

		unDisplayImg: function () {
			overlay.style.display = 'none';
			displayed = false;
		}
	}

	overlay.addEventListener('click', evenement.overlayClick);
	window.document.addEventListener('keydown', evenement.overlayKey);
	for(var i=0; i<lTabLiens; i++)
		tabLiens[i].addEventListener('click', evenement.clickLien);

})();
</script>


  </body>
</html>
" >> "./$html_file_name.html"
