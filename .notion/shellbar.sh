#!/bin/ksh
set -A _SYSV -- $(sysctl -n hw.sensors.cpu0.temp0 \
                            hw.sensors.acpithinkpad0.fan0 \
                            hw.cpuspeed \
                            | cut -d" " -f1)

TEMP="$(sysctl -n hw.sensors.cpu{0,1,2,3,4,5,6,7,8,9,10,11}.frequency0 \
        | cut -d. -f1 | sort)"

AVG="$(printf '(%s)/12' "$TEMP" | tr '\n' '+')"

out() { printf '%s/1000/1000\n' "$1" | bc; }

printf "  %s%% | %2s°C | %4sRPM | %4sMhz (~%4sMhz) |" \
    "$(apm -l)" "${_SYSV[0]}" "${_SYSV[1]}" "${_SYSV[2]}" "$(out $AVG)"
