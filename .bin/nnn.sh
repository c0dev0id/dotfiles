#!/bin/ksh

if [ -z "$1" ];
then
    print "Parameter missing."
    exit 2
fi

###################################################
# URLS
###################################################

if print "$1" | egrep -qi '^shell:|^ushell:|^cvs:';
then
    _server=${1%%:*}
    _dir=${1#*:}
    ssh -tt $_server "vim $_dir"
    exit 0
fi

if print "$1" | egrep -qi '^http[s]{0,1}://';
then
    case "$1" in
        *.mkv) mpv "$1"; ;;
        *.mp4) mpv "$1"; ;;
        *.webm) mpv "$1"; ;;
        *) sacc "$1"; ;;
    esac
    ${BROWSER:=luakit} "$1"
    exit 0
fi

if print "$1" | egrep -qi '^gopher://';
then
    case "$1" in
        *.mkv) mpv "$1"; ;;
        *.mp4) mpv "$1"; ;;
        *.webm) mpv "$1"; ;;
        *) sacc "$1"; ;;
    esac
    exit 0
fi

###################################################
# REAL FILES
###################################################

if [ ! -f "$1" ];
then
    print "Parameter is not a file."
    exit 1
fi

###################################################
# EXTENSIONS
###################################################

EXT="$(print "${1##*.}" | tr '[:upper:]' '[:lower:]')"

case "$EXT" in
    docx) libreoffice "$1"; ;;
    xlsx) libreoffice "$1"; ;;
    txt) vim "$1"; ;;
    m2ts) mpv "$1"; ;;
    sid) sidplay "$1"; ;;
    out) kdump -RTf "$1" | less; ;;
    *) unset EXT; ;;
esac

if [ ! -z "$EXT" ];
then
    exit 0;
fi

###################################################
# MIME TYPES
###################################################

case "$(file -ib "$1")" in
    # full qualified
    application/ogg) ogg123 "$1"; ;;
    application/pdf) mupdf-gl -XJA0 "$1"; ;;
    application/postscript) mupdf-gl -XJA0 "$1"; ;;
    application/vnd.oasis.opendocument.*) libreoffice "$1"; ;;
    audio/mpeg) mpg123 "$1"; ;;
    audio/midi) timidity "$1"; ;;
    # with wildcards
    audio/*) mpv "$1"; ;;
    video/*) mpv "$1"; ;;
    image/webp) mpv "$1"; ;;
    image/*) sxiv -N floating -g 1280x720+300+180 -ab "$1"; ;;
    # can't handle
    application/octet-stream) print "Sorry, can't handle: $1"; ;;
    # vim can handle a lot!
    *) vim "$1"; ;;
esac

