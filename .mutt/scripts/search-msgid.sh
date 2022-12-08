#!/bin/sh
luakit "https://marc.info/?i=$(cat - | sed -n 's/^Message-ID: <\(.*\)>/\1/p')"
