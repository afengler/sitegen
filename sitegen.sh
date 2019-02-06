#!/bin/sh

def_title="Andrew's Blog"
def_favicon="/assets/img/favicon.gif"

./navgen.sh src > dyn/nav.html

for i in $(find src/ -iname '*.html')
do
	page=${i#src/}
	[ -d "html/${page%/*.html}" -o "$page" = "${page%/*}" ] || mkdir -p html/${page%/*.html}
	cat static/head.html dyn/nav.html src/${page} static/foot.html > html/${page}

	#post-processing

	#title
	title=$(grep -Eo '<!-- TITLE .*? TITLE -->' html/${page})
	title=${title% TITLE -->}
	title=${title#<!-- TITLE }
	[ "$title" = "" ] && title=$def_title
	sed -I '' -e "s|%%TITLE%%|$title|" html/${page}

	#favicon
	favicon=$(grep -Eo '<!-- FAVICON .*? FAVICON -->' html/${page})
	favicon=${favicon% FAVICON -->}
	favicon=${favicon#<!-- FAVICON }
	[ "$favicon" = "" ] && favicon=$def_favicon
	sed -I '' -e "s|%%FAVICON%%|$favicon|" html/${page}

	#head lines
	head_line=$(grep -Eo '<!-- HEAD_LINE .*? HEAD_LINE -->' html/${page})
	head_line=${head_line% HEAD_LINE -->}
	head_line=${head_line#<!-- HEAD_LINE }
	sed -I '' -e "s|<!-- %%HEAD_LINE%% -->|$head_line|" html/${page}

done
