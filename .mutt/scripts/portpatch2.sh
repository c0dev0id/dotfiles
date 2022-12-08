#!/bin/sh

# needs converters/qprint
# mutt: macro pager,attach ^S "<pipe-message>cat > /tmp/muttpatch.diff<enter><shell-escape>~/.mutt/scripts/portpatch2.sh /tmp/muttpatch.diff<enter>"

clear
printf '\n---------------------------------------------------------------------\n'
grep -E 'Subject: |^Index|^RCS|^diff --git|^file +|^[-+]{3} ' "${1}"
printf '---------------------------------------------------------------------\n\n'

printf "Apply patch on path [defaults to /usr/ports]? "
read -r _path

printf "Fix quoted-printable mangeled patch? [y/N]: "
read -r _qprint

case ${_qprint} in
    [y|Y]) _catcmd="qprint -d"; ;;
        *) _catcmd="cat"; ;;
esac

printf "Strip? [0]: "
read -r _strip

${_catcmd} "${1}" | doas patch -Ep${_strip:=0} -d ${_path:=/usr/ports}
cd ${_path} && doas su
