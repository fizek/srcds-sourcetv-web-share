#!/bin/bash
gamepath=/home/sourcecs/sourcecs/dd2/cstrike
scriptpath=/root/demscript
webpath=/var/www/html

function movedemo()
{
	cd "$gamepath"
	#find ./demka -mtime +14 -type f -delete
	for demofile in $(ls *.dem | grep -v $(lsof *.dem | tail -n 1 | awk '{ print $9 }'))
	do 
		zipfile=$(echo "$demofile" | awk -F\. '{print $1".zip"}')
		zip -q demka/"$zipfile" "$demofile" && touch -d "$(date -R -r "$demofile")" demka/"$zipfile"
		rm -f "$demofile"
	done
}

function buildindex()
{
	cd "$scriptpath"
	#echo $(ls -lgGAth "$gamepath"/demka/ | awk '{print $4"\t"$5"\t"$3"\t"$6}') > "$scriptpath"/templist
	ls -1AgGht "$gamepath"/demka/ > "$scriptpath"/temp0
	grep dust temp0 | awk '{ print "date\t"$5"\t"$3"\t"$6 }' > "$scriptpath"/templist
	#godz=$(tail -n 1 templist | awk -F\- '{print substr ($4"\t"0"\t"2)}') 
	#minu=$(tail -n 1 templist | awk -F\- '{print substr ($4"\t"3"\t"2)}')
	echo '<html><head><title>DEMKA [PL]DD2][VIP] - www.SourceCs.pl</title></head>' > demka.html
	echo '<body><div class="logo"><a href="http://sourcecs.pl/"><img src="http://sourcecs.pl/images/SkillShot/header.png" alt="serwery gier" /></a></div><br /><h2>DEMKA [PL]DD2][VIP] - www.SourceCs.pl</h2><br />' >> demka.html
	#echo '<table border=1><tr><th>data</th><th>godz. pocz.</th><th>godz. konc.</th><th>rozmiar</th><th>nazwa</th></tr><tr>' >> demka.html
	echo '<table border=1><tr><th>godz. konc.</th><th>rozmiar</th><th>nazwa</th></tr><tr>' >> demka.html
	IFS=$'\n'
	for demofile2 in $(cat templist)
	do
		echo "$demofile2" | awk '{print "<td>"$2"</td><td>"$3"</td><td><a href=/demka/"$4">"$4"</a></td></tr><tr>"}' >> demka.html
	done
	echo '</tr></table></body></html>' >> demka.html
	cp -f demka.html "$webpath"/
	unset IFS
}
movedemo
buildindex
exit 0
