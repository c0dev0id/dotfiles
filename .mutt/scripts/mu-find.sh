#!/bin/ksh
printf "MU Seach: "
read -r term

mu find --clearlinks --format=links --linksdir=~/.cache/mu/results $term
