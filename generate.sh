clear

cd ../panwriter
yarn run website:build
cd -
rm -r try
cp -r ../panwriter/try .

pandoc -M mainfont='-apple-system, BlinkMacSystemFont, Segoe UI, sans-serif' -M monobackgroundcolor=#f0f0f0 -s \
  -M pagetitle='PanWriter' \
  --css styles.css -M document-css=true \
  -V header-includes='<link rel="icon" type="image/png" href="https://github.com/mb21/panwriter/raw/master/icons/icon.png" />' \
  -V header-includes='<script data-goatcounter="https://mb21.goatcounter.com/count" async src="//gc.zgo.at/count.js"></script>' \
  --include-after-body scripts.html \
  ../panwriter/src/website.md  --output index.html

python -m SimpleHTTPServer 8000 .
