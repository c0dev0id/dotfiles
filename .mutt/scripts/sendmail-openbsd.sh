#!/bin/sh
ssh sdk@cvs.openbsd.org "/usr/sbin/sendmail -F 'Stefan Hagen' -f sdk@openbsd.org -t"
