
if ! test -f links; then
UDD=$(mktemp -d)

mkdir -p $UDD

YYYY=2021

for YYYY in 2021 2020 2019 2018 2017 2016 2015; do

echo $YYYY

#URL="https://www.google.com/search?q=%22Best+of+arXiv.org+for+AI%2C+Machine+Learning%2C+and+Deep+Learning%22+site%3Ainsidebigdata.com+before%3A$YYYY-12-31+after%3A$YYYY-01-01"
URL="https://www.google.com/search?q=%22Best+of+arXiv.org+for+AI%2C+Machine+Learning%2C+and+Deep+Learning%22+site%3Ainsidebigdata.com+inurl%3A$YYYY"
google-chrome --headless --dump-dom --user-data-dir="$UDD" "$URL" > $YYYY_2.html

done

grep -I -is -hEro 'https://inside[^ ]*/best-[A-Za-z0-9/-]*/' 2*.html | sort | uniq > links

fi


xargs -n 1 curl < links > all.html
