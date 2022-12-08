#!/bin/ksh

linux_server() {
        while true
        do
            printf " %s   %3s%%   %s°C   %s (priv)   %4sMhz  \n" \
                "$(who | cut -d" " -f1 | sort -u | wc -l)" \
                "$(ps -u d034266 -o pcpu | awk '/[0-9\.]/ { s=s+$1 } END { printf("%.0d\n", s); }')" \
                "$(sensors | awk '/^Core/ { s=$3+s } END { printf("%2d\n", s/60); }')" \
                "$(df -h --output=avail /priv/ | tail -1)" \
                "$(lscpu | awk '/^CPU MHz:/ { printf("%.4d", $3) }')"
            sleep 5
        done
}

openbsd_laptop() {
        while true
        do
            set -A _SYSV -- $(sysctl -n \
                                hw.sensors.cpu0.temp0 \
                                hw.sensors.acpithinkpad0.fan0 \
                                hw.cpuspeed \
                                    | cut -d" " -f1)

            set -A _CPUV -- $(sysctl -n \
                                hw.sensors.cpu{0,1,2,3,4,5,6,7,8,9,10,11}.frequency0 \
                                    | cut -d"." -f1)

            AVG=$(avg "${_CPUV[@]}")

            printf " %s%%   %2s°C   %4sRPM   %4sMhz (~%4.4sMhz)  \n" \
                "$(apm -l)" "${_SYSV[0]}" "${_SYSV[1]}" "${_SYSV[2]}" "${AVG}";

            sleep 5
        done
}

case $(hostname) in
    ld*) linux_server; ;;
    *.home.codevoid.de) openbsd_laptop; ;;
    *.local.codevoid.de) openbsd_laptop; ;;
esac

