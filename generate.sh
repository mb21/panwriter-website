clear

cd ../panwriter
yarn run website:build
cd -
cp -r ../panwriter/try .

pandoc --metadata mainfont='-apple-system, BlinkMacSystemFont, Segoe UI, sans-serif' --metadata monobackgroundcolor=#f0f0f0 -s \
  -M pagetitle='PanWriter' \
  --css styles.css -M document-css=true \
  --include-before-body toolbar.html\
  --include-after-body scripts.html \
  ../panwriter/src/website.md  --output index.html

python -m SimpleHTTPServer 8000 .
