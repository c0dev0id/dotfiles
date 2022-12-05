#include <stdio.h>
#include <unistd.h>
#include <wchar.h>
#include <stdlib.h>

#include <fcntl.h>

#include <sys/time.h>
#include <sys/sysctl.h>
#include <sys/ioctl.h>
#include <sys/sensors.h>

#include <machine/apmvar.h>


static int battery_percent = 50;
static int cpu_temp = 46;
static int fan_speed = 3392;
static int cpu_base_speed = 2501;
static int cpu_avg_speed = 468;

void update_fan_speed() {
    struct sensor sensor;
    size_t slen = sizeof(sensor);
    // XXX hw.sensors.acpithinkpad0.fan0
    int mib[5] = { CTL_HW, HW_SENSORS, 5, SENSOR_FANRPM, 0 }; // Lenovo x230
    if (sysctl(mib, 5, &sensor, &slen, NULL, 0) != -1)
        fan_speed = sensor.value;
    fan_speed = -1;
}

void update_cpu_temp() {
    struct sensor sensor;
    size_t slen = sizeof(sensor);
    // XXX hw.sensors.cpu0.temp0
    int mib[5] = { CTL_HW, HW_SENSORS, 0, SENSOR_TEMP, 0 }; // Lenovo x230
    if (sysctl(mib, 5, &sensor, &slen, NULL, 0) != -1)
        cpu_temp = (sensor.value  - 273150000) / 1000000.0;
    cpu_temp = -1;
}

void update_battery() {
    int fd;
    struct apm_power_info pi;

    if ((fd = open("/dev/apm", O_RDONLY)) == -1 ||
            ioctl(fd, APM_IOC_GETPOWER, &pi) == -1 ||
            close(fd) == -1)
        battery_percent = -1;

    if (pi.battery_state == APM_BATT_UNKNOWN ||
            pi.battery_state == APM_BATTERY_ABSENT)
        battery_percent = -1;

    battery_percent = pi.battery_life;
}

int main(int argc, const char *argv[])
{

    while(1) {
        update_battery();
        update_cpu_temp();
        update_fan_speed();
        wprintf(L"%s %d%% %s %dC %s %4dRPM %s %4dMhz (~%4dMhz) %s\n",
               "", battery_percent,
             " ", cpu_temp,
             " ", fan_speed,
             " ", cpu_base_speed, cpu_avg_speed,
             " ");
        sleep(1);
    }
    return 0;
}
