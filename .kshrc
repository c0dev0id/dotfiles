# ksh environment file

########################################################################
# ENVIRONMENT VARIABLES
########################################################################

### SEARCH PATHS
PATH=\
~/bin\
:~/.bin\
:/bin\
:/sbin\
:/usr/bin\
:/usr/sbin\
:/usr/local/bin\
:/usr/local/sbin\
:/usr/X11R6/bin\
:/usr/games\
:/usr/ports/infrastructure/bin\
:/usr/local/cobol/bin
PATH="$PATH:/opt/zodiac/bin"
export PATH

MANPATH=/usr/share/man:/usr/X11R6/man:/usr/local/man
export MANPATH

### LANGUAGE
LANG=en_US.UTF-8
LC_ALL=en_US.UTF-8
LC_MESSAGES=C
LC_NUMERIC=C
LC_TIME=en_US.UTF-8
export LANG LC_ALL LC_MESSAGES LC_NUMERIC LC_TIME

########################################################################
# STOP HERE IF NON INTERACTIVE
########################################################################

[[ $- != *i* ]] && return

########################################################################
# INTERACTIVE ENVIRONMENT
########################################################################

HOSTNAME=$(hostname)
set -A UNAME -- $(uname -a)
export HOSTNAME UNAME

case ${HOSTNAME} in
    *.home.codevoid.de)  PKGOPT="-Dsnap"; ;;
    openbsd.codevoid.de) PKGOPT="-Dsnap"; ;;
esac

### HISTORY
HISTCONTROL=ignoredups:ignorespace:erasedups
HISTFILE=$HOME/.ksh-history
HISTSIZE=2000
export HISTCONTROL HISTFILE HISTSIZE

### CDPATH
CDPATH=.:/usr/ports:~/code
export CDPATH

### SOFTWARE PREFERENCES
EDITOR="vim"
VISUAL="vim"
BROWSER="luakit"
TUIR_BROWSER="$BROWSER"
PAGER="less"
export EDITOR VISUAL BROWSER TUIR_BROWSER PAGER

### NNN
NNN_OPTS="cErxAJ"
NNN_OPENER="nnn.sh"
NNN_PLUG='o:-!mpv "$nnn";x:-!sh -x "$nnn";i:imgview;'
NNN_ARCHIVE="\\.(7z|bz2|gz|tar|tgz|zip)$"
NNN_SSHFS='doas sshfs -d -o reconnect -o uid=1000 -o gid=1000'
NNN_COLORS='#0a1b2c3d;1234'
NNN_FCOLORS='c1e2272e006033f7c6d6abc4'
export NNN_OPTS NNN_OPENER NNN_PLUG NNN_ARCHIVE NNN_SSHFS
export NNN_COLORS NNN_FCOLORS

# LESS
LESS="--buffers=-1 -g -i -J -M --tilde -R"
LESSHISTFILE="$HOME/.less-history"
export LESS LESSHISTFILE

### SLNR
SLRNPULL_ROOT=$HOME/.slrnpull
NNTPSERVER=read.news.tnib.de
export SLRNPULL_ROOT NNTPSERVER

### GOT
GOT_AUTHOR="Stefan Hagen <sh+got@codevoid.de>"
TOG_COLORS=1
export GOT_AUTHOR
export TOG_COLORS

### BUPSTASH
BUPSTASH_REPOSITORY=ssh://sdk@storage.bupstash.io
#export BUPSTASH_KEY=/home/sdk/backups.key
export BUPSTASH_REPOSITORY

### PASSWORD-STORE
PASSWORD_STORE_ENABLE_EXTENSIONS=true
export PASSWORD_STORE_ENABLE_EXTENSIONS

########################################################################
# PROMPT (SIMPLE)
########################################################################

PS1="\${?}\w\\$ "

########################################################################
# SHELL SETTINGS
########################################################################

ulimit -c 0
stty -ixon -ixoff
set -o emacs
set bell-style none

########################################################################
# ALIASES
########################################################################

# configuration files
alias ssh-config="gpg-edit ~/.ssh/config"
alias kshrc="vim ~/.kshrc"
alias muttrc="vim ~/.mutt/rc-common"
alias vimrc="vim ~/.vim/vimrc"
alias kludges="vim ~/.notion/cfg_kludges.lua"
alias spectrwmrc="vim ~/.config/spectrwm/spectrwm.conf"
alias dev-kernconf="doas vim /sys/arch/amd64/conf/GENERIC.MP"

# vim-snippets
alias snips="vim ~/.vim/bundle/vim-snipmate/snippets/sh.snippets"
alias snipc="vim ~/.vim/bundle/vim-snipmate/snippets/c.snippets"
alias snip="vim ~/.vim/bundle/vim-snipmate/snippets/_.snippets"

# system
alias sudo="doas"
alias su="doas su"

# translation
alias trans-en="trans -l de -s en -t de --no-ansi"
alias trans-de="trans -l en -s de -t en --no-ansi"

# packages
alias pkg_add="doas \pkg_add ${PKGOPT}"
alias pkg_delete="doas \pkg_delete ${PKGOPT}"
alias pkg_info="\pkg_info ${PKGOPT}"

# programs
alias mupdf="mupdf-gl -XJ"

# network
alias edit_dns="ssh -t sdk@dns.codevoid.de \"doas vim /var/nsd/zones/master/codevoid.de && doas nsd-control reload\""
alias edit_gopher="vim sftp://sdk@gopher.codevoid.de/../www/htdocs/gopher/"
alias ts="doas tailscale"
ts-vpn() { doas tailscale up --exit-node=100.89.60.42; }

x() { ssh -t home.codevoid.de 'tmux -u attach || tmux -u'; }
t() { ssh -t tweety.home.codevoid.de 'tmux -u attach || tmux -u'; }
b() { ssh -t barton.oldbsd.de 'tmux -u attach || tmux -u'; }


netrestart() {(
    set -x
    doas ifconfig trunk0 destroy
    doas sh /etc/netstart
    doas rcctl restart resolvd
    doas rcctl restart dhcpleased
)}

scr() {
    [ -z "$1" ] \
        && doas wsconsctl -n display.brightness \
        || doas wsconsctl display.brightness="$1"
}

pass-reinit() {
    pass git pull
    pass init $(<~/.password-store/.gpg-id)
    pass git push
}

cg() {
    test -z "${1}" \
        && echo "usage: cg <ChatNet>" \
        && return

    case ${1} in
        b*) _net=Bitreich; ;;
        c*) _net=CuffLink; ;;
        e*) _net=EfNet; ;;
        h*) _net=HackInt; ;;
        i*) _net=IRCNet; ;;
        l*) _net=LiberaChat; ;;
        o*) _net=OFTC; ;;
        r*) _net=RobustIRC; ;;
        u*) _net=UUGRN; ;;
        *) _net=${1}; ;;
    esac

    catgirl \
        -C copy \
        -N notify-send \
        -O nnn.sh \
        -C xcoopy \
        -i "* [JPQ][OAU][IR][NT]" \
        -l \
        -h shell.codevoid.de \
        -p 40004 \
        -r x \
        -u sdk \
        -n sdk \
        -w "sdk@$(hostname -s)/${_net}:$(pass Internet/znc)"
}

# mount
alias mount_msdos="doas \mount_msdos -o nodev,nosuid,noatime -u 1000 -g 1000"
mount_tank()  { awk '$3=="nfs"{print $2}' /etc/fstab | xargs -n1 doas mount; }
umount_tank() { awk '$3=="nfs"{print $2}' /etc/fstab | xargs -n1 doas umount; }

# gopher bookmarks
alias fefe="sacc gopher://codevoid.de/1/fefe"
alias hn="sacc gopher://codevoid.de/1/hn"
alias cv="sacc gopher://codevoid.de"

# pim
alias notes="vim scp://sdk@shell.codevoid.de/work/notes/notes.txt"
alias events="vim scp://sdk@shell.codevoid.de/work/notes/events.txt"
caly() { ncal -C $(date +%Y); }

# music
alias music_psychedelik="mpg123 -b 1024 http://62.210.114.63:8000"
alias music_progressive="mpg123 -b 1024 http://62.210.114.63:8010"
alias music_drum-n-bass="mpg123 -b 1024 http://62.210.114.63:8030"
alias music_ambient="mpg123 http://62.210.114.63:8002/listen.mp3"
alias music_tilderadio="ogg123 https://tilderadio.org/listen"
alias music_bitreich="mpv gopher://bitreich.org/9/radio/listen"
alias flac_encode="flac -e --best --delete-input-file"

# security
alias gpa="gpa -k"
alias htpasswd-openssl="openssl passwd -apr1"
alias ssh-keygen-ed25519="ssh-keygen -t ed25519 -a 420 -C sh@codevoid.de"
alias insecuresh="ssh -o HostKeyAlgorithms=+ssh-rsa -o KexAlgorithms=+diffie-hellman-group1-sha1 -o Ciphers=+aes256-cbc"

pw() { pwgen -1 -y --remove-chars=\~\`\"\'{}\(\)\[\]\*:/.\;\|,\<\> 22; }

# backup
alias tarsnap="doas \tarsnap"

# archives
alias innoextract="\innoextract -g --no-gog-galaxy"

# games
alias quake="\vkquake +game id1"
alias quake-mp1-scourge_of_armagon="\vkquake +game hipnotic"
alias quake-mp2-dissolution_of_eternity="\vkquake +game rogue"
alias quake2="\quake2 +game baseq2"
alias quake2-mp1-the_reconning="\quake2 +game xatrix"
alias quake2-mp2-ground_zero="\quake2 +game rogue"
alias quake2-ex1-jaggernaut="\quake2 +game jaggernaut"
alias quake2-ex2-zaero="\quake2 +game zaero"
alias doom3="dhewm3 +set r_fullscreen 1 +set com_fixedtic -1"
alias steam-list="steamctl --user sdk82 apps list"
alias steam-download="steamctl --user sdk82 depot download -os linux64 -a"

# terminal internet stuff
alias terminal_map="telnet mapscii.me"
alias terminal_bofh="telnet towel.blinkenlights.nl 666"
alias terminal_starwars="telnet towel.blinkenlights.nl 23"
alias terminal_cnn="links http://lite.cnn.io/en"
alias terminal_8ball="lynx -width=300 --dump https://codevoid.de/8Ball"
alias terminal_weather="curl wttr.in/Hockenheim"
alias terminal_bbs="telnet gopher.su 1234"
alias terminal_unix50="ssh unix50@unix50.org"

# bookmarks
alias uug-mastodon="firefox https://chaos.social/u/uugrn"
alias uug-twitter="firefox https://twitter.com/@uugrn"
alias discord-me="firefox https://discord.com/channels/@me"
alias discord-immortals="firefox https://discord.com/channels/991041843871502366/1000826654974812160"
alias cups-config="firefox http://localhost:631"


# monitoring
lr() {
    [ -z "$1" ] \
        && print "l-remote <hostname>" && return
    if [ -z "$2" ]; then
        _xtitle "$1: /var/log/messages (all)";
        ssh -t "$1" "doas tail -f /var/log/{messages,daemon,secure,maillog}"
    else
        _xtitle "$1: /var/log/messages (grep $2)";
        ssh -t "$1" "doas tail -f /var/log/{messages,daemon,secure,maillog} | fgrep -i $2"
    fi
}
l() {
    if [ -z "$1" ];
    then
        _xtitle "/var/log/messages (all)";
        doas tail -n 4000 -f /var/log/{messages,daemon,secure,maillog}
    else
        _xtitle "/var/log/messages (grep: $1)";
        doas tail -n 4000 -f /var/log/{messages,daemon,secure,maillog} | fgrep -i "$1"
    fi
}


########################################################################
# EMAIL HANDLING
########################################################################

# mailboxes
MUTT_HOST="imaps://mail.codevoid.de"

# account aliases
alias mutt-acc-gmx="\mutt -F $HOME/.mutt/rc-account-gmx"
alias mutt-acc-priv="\mutt -F $HOME/.mutt/rc-account-private"
alias mutt-acc-work="\mutt -F $HOME/.mutt/rc-account-work"
alias mutt-acc-offl="\mutt -F $HOME/.mutt/rc-account-offline"
alias mutt-acc-mborg="\mutt -F $HOME/.mutt/rc-account-mborg"
alias mutt-acc-uugrn="\mutt -F $HOME/.mutt/rc-account-uugrn"

# default
alias mutt="mutt-acc-priv"
alias muttopen="\mutt -F ~/.mutt/rc-common -f"

# select mailbox
mutt-textmail() { mutt-acc-priv -f $MUTT_HOST/Mailboxes/textmail.me/$1; }
mutt-codevoid() { mutt-acc-priv -f $MUTT_HOST/Mailboxes/codevoid.de/sh+$1; }

# shortcuts
alias mutt-all="mutt -f $MUTT_HOST/Virtual/ALL"
alias mutt-amazon="mutt-textmail amazon"
alias mutt-ccc-intern="mutt-textmail ccc-intern"
alias mutt-last-day="mutt -f $MUTT_HOST/Virtual/LAST_DAY"
alias mutt-last-week="mutt -f $MUTT_HOST/Virtual/LAST_WEEK"
alias mutt-last-month="mutt -f $MUTT_HOST/Virtual/LAST_MONTH"
alias mutt-last-year="mutt -f $MUTT_HOST/Virtual/LAST_YEAR"
alias mutt-lieferando="mutt-textmail lieferando"
alias mutt-mutt-users="mutt-codevoid mutt-users"
alias mutt-openbsd-all="mutt -f $MUTT_HOST/Virtual/OpenBSD"
alias mutt-openbsd-bugs="mutt-codevoid openbsd-bugs"
alias mutt-got="mutt-codevoid got"
alias mutt-openbsd-hackers="mutt-codevoid openbsd-hackers"
alias mutt-openbsd-misc="mutt-codevoid openbsd-misc"
alias mutt-openbsd-ports-bugs="mutt-codevoid openbsd-ports-bugs"
alias mutt-openbsd-ports-cvs="mutt-codevoid openbsd-ports-cvs"
alias mutt-openbsd-ports="mutt-codevoid openbsd-ports"
alias mutt-openbsd-x11="mutt-codevoid openbsd-x11"
alias mutt-openbsd-sparc="mutt-codevoid openbsd-sparc"
alias mutt-openbsd-src-cvs="mutt-codevoid openbsd-src-cvs"
alias mutt-openbsd-tech="mutt-codevoid openbsd-tech"
alias mutt-paypal="mutt-textmail paypal"
alias mutt-uugrn="mutt-codevoid uugrn"
alias mutt-vorstand="mutt-codevoid vorstand"
alias otech="mutt -f $MUTT_HOST/Virtual/OpenBSD-tech"
alias oports="mutt -f $MUTT_HOST/Virtual/OpenBSD-ports"
alias omisc="mutt -f $MUTT_HOST/Virtual/OpenBSD-misc"

########################################################################
# OPENBSD PORT TOOLS
########################################################################

alias cvs-diff='cvs -d sdk@cvs.openbsd.org:/cvs diff -uNp'
alias cvs-release='cvs -d sdk@cvs.openbsd.org:/cvs release'
alias cvs-update="doas cvs -z 5 -d sdk@cvs.openbsd.org:/cvs -q up -Pd -A"

cvs-import-simulate() {(
     set -ex
    _dir=$(basename $PWD)
    _pwd=$(dirname $PWD)
    cvs -d sdk@cvs.openbsd.org:/cvs -n import \
                  ports/$_pwd/$_dir sdk sdk_$(date +"%Y%m%d")
)}

CVSDIR=/usr/ports
cvs-checkout-ports() {( set -x; cd $CVSDIR && doas cvs -z 1 -qd sdk@cvs.openbsd.org:/cvs checkout -P ports; )}
cvs-checkout-src() {( set -x; cd $CVSDIR && doas cvs -z 1 -qd sdk@cvs.openbsd.org:/cvs checkout -P src; )}
cvs-checkout-www() {( set -x; cd $CVSDIR && doas cvs -z 1 -qd sdk@cvs.openbsd.org:/cvs checkout -P www; )}
cvs-checkout-xenocara() {( set -x; cd $CVSDIR && doas cvs -z 1 -qd sdk@cvs.openbsd.org:/cvs checkout -P xenocara; )}

cvs-update-ports() {( set -x; cd $CVSDIR/ports && doas cvs -z 1 -d sdk@cvs.openbsd.org:/cvs -q up -Pd -A;)}
cvs-update-src() {( set -x; cd $CVSDIR/src && doas cvs -z 1 -d sdk@cvs.openbsd.org:/cvs -q up -Pd -A;)}
cvs-update-www() {( set -x; cd $CVSDIR/www && doas cvs -z 1 -d sdk@cvs.openbsd.org:/cvs -q up -Pd -A;)}
cvs-update-xenocara() {( set -x; cd $CVSDIR/xenocara && doas cvs -z 1 -d sdk@cvs.openbsd.org:/cvs -q up -Pd -A;)}
cvs-commit() {( set -x; doas cvs -d sdk@cvs.openbsd.org:/cvs commit $@; )}

cvs-checkout-all() {
    cvs-checkout-src
    cvs-checkout-xenocara
    cvs-checkout-ports
    cvs-checkout-www
}
cvs-update-all() {
    cvs-update-src
    cvs-update-xenocara
    cvs-update-ports
    cvs-update-www
}
alias update-ksh="cd /usr/src/bin/ksh \
                    && doas make clean \
                    && doas make obj \
                    && doas make \
                    && doas make install"




alias pmark="port mark"
p() { cd "$(port src)" && echo $PWD; }
pj() { cd "$(port jump $1)" && echo $PWD; }
po() { cd "$(port obj)" && echo $PWD; }

alias portclean="port clean"
alias portsweep='doas find . \( -name "*.orig" -or -empty \) -delete'
alias portdiff="port diff"

alias port-modgo-update='make MODGO_VERSION=latest modgo-gen-modules > modules.inc'

alias proot-rebuild="doas proot -c /etc/proot.conf; doas chroot /home/dpb pkg_add ccache"
alias proot-do="doas chroot /home/dpb/"

alias dmake="doas /usr/ports/infrastructure/bin/dpb -B /home/dpb -c -p 4 -j 4"


dev-dir() {
    cd "$(cat /home/sdk/.dev/dir)";
}

dlast() {
    doas -u build vim -c ':browse oldfiles'
}
dvim() {
    doas -u build vim
}
ddiff() {(
    cd /usr/src
    f="$(cat /var/cache/dmark | sed 's|/usr/src/||g')"
    cvs-diff "$f" | tee "/home/sdk/$(basename "$f").diff"
    readlink -f "/home/sdk/$(basename "$f").diff"
)}
dgrepsys() {
    ugrep --exclude-dir="CVS" \
          --include="*.h" \
          --include="*.c" \
          --include="*.txt" \
          --include="*.pl" \
          --include="*.pm" \
          --include="*.sh" \
          --recursive \
          "$1" \
          /usr/src/sys/
}
dgrep() {
    ugrep --exclude-dir="CVS" \
          --include="*.h" \
          --include="*.c" \
          --include="*.txt" \
          --include="*.pl" \
          --include="*.pm" \
          --include="*.sh" \
          --recursive \
          "$1" \
          /usr/src/
}

pack() {
    doas tar czvf "$1.tgz" "$1" \
        && readlink -f "$1.tgz"
}

########################################################################
# TWITCH FROM CLI
########################################################################

alias twitch-play="mpv https://www.twitch.tv/c0dev0id"
twitch-stream() {
    local API_KEY=$(pass Internet/Twitch | head -1)
    local RES=$(xrandr | grep "*+" | awk '{print $1}')
    local FAUX_OPTS="-d snd/default -m -vmic 5.0 -vmon 0.2 -r $RES -f 20 -b 4000"
    (
        set -x
        fauxstream $FAUX_OPTS rtmp://live-ams.twitch.tv/app/$API_KEY
    )
}

########################################################################
# DOTFILES WITH GIT
########################################################################

alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

dotfiles_autoupdate() {
    config add -u && \
    config commit -m "Update $(date +"%Y-%m-%d %H:%M") \
        $(uname -s)/$(uname -m)" && config push
}

dotfiles_init() {
    git --no-replace-objects clone --bare --depth 1 \
        sdk@home.codevoid.de:.dotfiles.git $HOME/.cfg;
    config config --local status.showUntrackedFiles no;
    mkdir -p $HOME/.vim/undo $HOME/.vim/swapfiles $HOME/.vim/backup;
    config checkout -f
}

########################################################################
# FILE SHARING
########################################################################

dohttp_clean() {
    ssh sdk@codevoid.de rm -rvf "/home/www/htdocs/http/*";
}
dohttp_upload() {
    local _file=$(readlink -f "$1");
    local _name=$(cleanstring "$1");
    scp -r "$_file" sdk@codevoid.de:/home/www/htdocs/http/$_name
    ssh -t sdk@codevoid.de doas chown -R sdk:www "/home/www/htdocs/http/$_name"
    printf "https://codevoid.de/h/$_name\n";
}
cleanstring() {
    printf '%s' "$1" | tr "[:upper:]ÄÖÜ " "[:lower:]äöü_" \
        | sed 's/ä/ae/g;s/ö/oe/g;s/ü/ue/g;s/ß/ss/g';
}

########################################################################
# YOUTUBE-DL
########################################################################
YTDL_AGENT="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/92.0.4506.0 Safari/537.36"
YTDL_OPTS="-i --no-part --abort-on-unavailable-fragment --buffer-size 16K --fragment-retries 100 --http-chunk-size 10M"
alias youtube-dl="yt-dlp"
ytdl() {
    local FMT="bestvideo[ext=mp4][height<=1080]+bestaudio[ext=m4a]/best[ext=mp4]/best"
    yt-dlp $YTDL_OPTS --user-agent "$YTDL_AGENT" -f "$FMT" "$@";
}

ytdl_playlist() { 
    local FMT="bestvideo[ext=mp4][height<=1080]+bestaudio[ext=m4a]/best[ext=mp4]/best"
    yt-dlp $YTDL_OPTS --user-agent "$YTDL_AGENT" -f "$FMT" -o '%(playlist_title)s/%(title)s.%(ext)s' "$@";
}

ytdl_channel()  {
    local FMT="bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"
    yt-dlp $YTDL_OPTS --user-agent "$YTDL_AGENT" --download-archive ytdl_channel.txt -f "$FMT" \
        -o '%(upload_date)s - %(title)s.%(ext)s' "$@";
}
ytdl_bandcamp() {
    yt-dlp $YTDL_OPTS --user-agent "$YTDL_AGENT" -x --audio-format mp3 -i --embed-thumbnail \
        --add-metadata -o '%(artist)s/%(album)s/%(track_number)02d - %(track)s.%(ext)s' "$@";
}
ytdl_audio() {
    yt-dlp $YTDL_OPTS --user-agent "$YTDL_AGENT" -f bestaudio --extract-audio --embed-thumbnail \
        --add-metadata -o "%(title)s-%(id)s.%(ext)s" "$@";
}

########################################################################
# KSH COMPLETIONS
########################################################################

[ -f $HOME/.ksh-complete ] && . $HOME/.ksh-complete

########################################################################
# SCREEN CONFIGURATION
########################################################################

devdir() {
    cd "$(cat /home/sdk/.dev/dir)"
}
barrier_s() {
    barriers -n $(hostname -s) --enable-crypto
}
barrier_c() {
    if [ -z "$1" ]
    then
        echo "No IP provided, trying 10.10.10.2"
        barrierc -n $(hostname -s) --enable-crypto 10.10.10.2
    else
        barrierc -n $(hostname -s) --enable-crypto $1
    fi
}
xr_primary() {
    xrandr --listmonitors | awk '/ 0:/{ print $4 }'
}
xr_secondary() {
    xrandr | awk '/ connected/ { print $1 }' | fgrep -v $(xr_primary)
}
xr_off() {
    xrandr | awk '/disconnected/ { print $1 }'
}
alias xrandr_portrait="sync; xrandr --output DP-1 --rotate left"
xrandr_set() {
    set -xe
    for scr in $(xr_secondary)
    do
        xrandr --output $scr --$1 $(xr_primary) --mode 1920x1080
    done
    for scr in $(xr_off)
    do
        xrandr --output $scr --off
    done
}
xrandr_mirror() {
    xrandr_set same-as
}
xrandr_extend_above() {
    xrandr_set above
}
xrandr_extend_right() {
    xrandr_set right-of
}
xrandr_extend_left() {
    xrandr_set left-of
}
xrandr_native() {
    xrandr --output $(xr_primary) --auto
}
xrandr_720p() {
    xrandr --output $(xr_primary) --mode 1280x720
}
xrandr_1080p() {
    xrandr --output $(xr_primary) --mode 1920x1080
}
xrandr_4k() {
    xrandr --output $(xr_primary) --mode 3840x2160
}

########################################################################
# GNUPG AGENT
########################################################################

if [ -f $HOME/.gnupg/pubring.gpg ];
then
    GPG_TTY=$(tty)
    SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    SSH_AUTH_SOCK_EXTRA=${SSH_AUTH_SOCK%%.ssh}.extra
    export GPG_TTY SSH_AUTH_SOCK SSH_AUTH_SOCK_EXTRA
    pgrep -qu sdk gpg-agent || gpg-connect-agent -q /bye
fi
