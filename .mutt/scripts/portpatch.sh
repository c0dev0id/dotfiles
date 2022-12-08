#!/bin/sh

strip=0

clear
printf '\n---------------------------------------------------------------------\n'
egrep '^Index|^RCS|^diff --git|^file +' "$1" | sed 's,/cvs,/usr,g'
printf '---------------------------------------------------------------------\n\n'

printf "Path for patch [/usr/ports]? "
read _path

[ -z "$_path" ] && _path=/usr/ports
egrep -q '^diff --git a/' "$1" && strip=1

#print "Trying to apply patch"
#qprint -d "$1" "$1.out"

doas patch -Ep"$strip" -d $_path < "$1"
cd $_path && ksh
