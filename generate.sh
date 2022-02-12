clear

cd ../panwriter
yarn run website:build
cd -
rm -r try
cp -r ../panwriter/try .

FONT='-apple-system, BlinkMacSystemFont, Segoe UI, sans-serif'
INCLUDES='<link rel="icon" type="image/png" href="https://github.com/mb21/panwriter/raw/master/icons/icon.png" />
<script data-goatcounter="https://mb21.goatcounter.com/count" async src="//gc.zgo.at/count.js"></script>'
INDEXCSS='<style>
#download {
  font-weight: bold;
}
.download ul {
  padding-left: 0;
}
.download ul > li {
  list-style: none;
  margin: 1em 1em 1em 0;
  display: inline-block;
}
.download ul > li > a {
  border: 1px solid grey;
  padding: 10px 15px;
  border-radius: 5px;
  text-decoration: none;
}
.download ul > li > a:hover {
  opacity: 0.75;
}
@media (max-width: 600px) {
  .download ul > li:nth-child(2) {
    display: none;
  }
}
</style>'


pandoc -M pagetitle='PanWriter' \
  -M mainfont="$FONT" -M monobackgroundcolor=#f0f0f0 -s \
  --css styles.css -M document-css=true \
  -V header-includes="$INCLUDES" \
  -V header-includes="$INDEXCSS" \
  --include-after-body scripts.html \
  --include-before-body nav.html \
  download.md ../panwriter/src/website.md  --output index.html

pandoc --toc \
  -M mainfont="$FONT" -M monobackgroundcolor=#f0f0f0 -s \
  --css styles.css -M document-css=true \
  -V header-includes="$INCLUDES" \
  -V toc-title="Table of Contents"\
  --include-before-body nav.html \
  ../panwriter/MANUAL.md  --output MANUAL.html

python -m SimpleHTTPServer 8000 .
