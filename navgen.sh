#!/bin/sh

parsedir ()
{
	c=$1
	cd $c
	if [ "$c" != '.' ]
	then
		base="${base}${c}/"
		echo "<li>$c</li>"
	fi

	echo "<ul>"
	for file in *
	do
		name=${file%.html}
		if [ -f $file -a "${name}" != "$file" ]
		then
			noindex=$(grep -Eo '<!-- NOINDEX -->' ${file})
			if [ -z "${noindex}" ]
			then
				echo "<li><a href=\"${base}${file}\">${name}</a></li>"
			fi
		fi
	done

	for file in *
	do
		if [ -d $file ]
		then
			parsedir $file
		fi
	done

	echo "</ul>"
	base=${base%$c}
	cd ..
}

base='/'
cd $1
echo "<nav>"
echo "<h2>Contents</h2>"
parsedir .
echo "</nav>"
