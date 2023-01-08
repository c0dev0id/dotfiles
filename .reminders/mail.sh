#/bin/sh

cd /home/sdk/.reminders

( cd personal && git pull )
( cd uugrn && git pull )

export COLUMNS=80

remind -s+2 /home/sdk/.reminders \
    | cut -d" " -f1 -f6- \
    | sort \
    | sed 's|\(....\)/\(..\)/\(..\) \([^ ]*\) \([^\|]*\).*|\3.\2.\1 \| \4 \| \5|g' \
    | sed 's|\(....\)/\(..\)/\(..\) \([^\|]*\).*|\3.\2.\1 \| \| \4|g' \
    | column -t -s "|" \
    | mail \
        -s "Todays Reminders (+7 days)" \
        -r "Remind <sh@dalek.home.codevoid.de>" \
        sh@codevoid.de
