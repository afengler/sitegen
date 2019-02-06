# sitegen
The greatest static site generator possible

## How to use it

Find a directory you like.  I recomend something like /var/www/WEBSITE

Download sitegen.sh and navgen.sh to that directory.

Make directories called src, html, static, and dyn

Put the body of each page int src/path/to/page.html

Put your header and footer into static/head.html and static/foot.html

Run sitegen.sh (make sure you're cd'd to /var/www/WEBSITE)

The compiled pages will exist in html/path/to/page.shtml
