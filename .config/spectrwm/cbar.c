#include <stdio.h>
#include <unistd.h>
#include <wchar.h>
#include <stdlib.h>
#include <string.h>

#include <fcntl.h>

#include <sys/time.h>
#include <sys/sysctl.h>
#include <sys/ioctl.h>
#include <sys/sensors.h>

#include <sndio.h>

#include <sys/types.h>
#include <sys/param.h>

#include <machine/apmvar.h>


static int battery_percent = 23;
static int cpu_temp = 23;
static int fan_speed = 23;
static int cpu_base_speed = 23;
static int cpu_avg_speed = 23;
static int volume = 23;


 //void update_volume(void *arg, unsigned addr, unsigned val) {
//     printf("volume update\n");
// 
// }
// 
// void register_volume_callback() {
//   struct sioctl_hdl *hdl;
// 
//   hdl = sioctl_open(SIO_DEVANY, SIOCTL_READ, 0);
//   sioctl_onval(hdl, update_volume, NULL);
//   sioctl_close(hdl);
// }

void update_cpu_base_speed() {
    size_t slen = sizeof(cpu_base_speed);
    int mib[5] = { CTL_HW, HW_CPUSPEED }; // Lenovo x1g10
    if (sysctl(mib, 2, &cpu_base_speed, &slen, NULL, 0) == -1) {
        cpu_base_speed = -1;
    }
}

void update_cpu_avg_speed() {
    struct sensor sensor;
    size_t slen = sizeof(sensor);
    int i;
    for (i = 0; i < 12; i++) {
        int mib[5] = { CTL_HW, HW_SENSORS, 0, SENSOR_FREQ, 0 }; // Lenovo x1g10
        if (sysctl(mib, 5, &sensor, &slen, NULL, 0) != -1) {
            cpu_avg_speed += ( sensor.value / 1000000 / 1000000 );
        }
    }
    cpu_avg_speed = cpu_avg_speed / i;
}

void update_fan_speed() {
    struct sensor sensor;
    size_t slen = sizeof(sensor);
    // int mib[5] = { CTL_HW, HW_SENSORS, 5, SENSOR_FANRPM, 0 }; // Lenovo x230
    int mib[5] = { CTL_HW, HW_SENSORS, 12, SENSOR_FANRPM, 0 }; // Lenovo x1g10
    if (sysctl(mib, 5, &sensor, &slen, NULL, 0) != -1) {
        fan_speed = sensor.value;
        return;
    }
    fan_speed = -1;
}

void update_cpu_temp() {
    struct sensor sensor;
    size_t slen = sizeof(sensor);
    //int mib[5] = { CTL_HW, HW_SENSORS, 0, SENSOR_TEMP, 0 }; // cpu0.temp0 (x230)
    int mib[5] = { CTL_HW, HW_SENSORS, 12, SENSOR_TEMP, 0 }; // acpitz0.temp0 (x1)
    if (sysctl(mib, 5, &sensor, &slen, NULL, 0) != -1) {
        cpu_temp = (sensor.value  - 273150000) / 1000000.0;
        return;
    }
    cpu_temp = -1;
}

void update_battery() {
    int fd;
    struct apm_power_info pi;

    if ((fd = open("/dev/apm", O_RDONLY)) == -1 ||
            ioctl(fd, APM_IOC_GETPOWER, &pi) == -1 ||
            close(fd) == -1) {
        battery_percent = -1;
        return;
    }

    if (pi.battery_state == APM_BATT_UNKNOWN ||
            pi.battery_state == APM_BATTERY_ABSENT) {
        battery_percent = -1;
        return;
    }

    battery_percent = pi.battery_life;
}

int main(int argc, const char *argv[])
{

    //register_volume_callback();

    while(1) {

        // XXX can update at different intervals
        update_battery();
        update_cpu_temp();
        update_cpu_avg_speed();
        update_cpu_base_speed();
        update_fan_speed();

        wprintf(L"%s %d%% %s %dC %s %4dRPM %s %4dMhz (~%4dMhz) %s %d %s\n",
               "", battery_percent,
             " ", cpu_temp,
             " ", fan_speed,
             " ", cpu_base_speed, cpu_avg_speed,
             " ", volume,
             " ");
        sleep(1);
    }
    return 0;
}
