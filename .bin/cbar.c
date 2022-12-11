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
#include <sys/types.h>
#include <sys/param.h>

#include <machine/apmvar.h>

#include <sndio.h>

#include <locale.h>


static unsigned int battery_percent = 23;
static unsigned int cpu_temp = 23;
static unsigned int fan_speed = 23;
static unsigned int cpu_base_speed = 23;
static unsigned int cpu_avg_speed = 23;
static unsigned int volume = 23;

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
    setlocale(LC_CTYPE, "C");
    setlocale(LC_ALL, "en_US.UTF-8");

    const wchar_t sep =  0xE621; // 
    const wchar_t bat =  0xF583; // 
    const wchar_t tmp =  0xF2C9; // 
    const wchar_t fan =  0xF70F; // 
    const wchar_t freq = 0xE234; // 
    const wchar_t time = 0xE383; // 

    while(1) {

        update_battery();
        update_cpu_temp();
        update_cpu_avg_speed();
        update_cpu_base_speed();
        update_fan_speed();

        printf("%lc %d%% %lc %lc %dC %lc %lc %4dRPM %lc %lc %4dMhz (~%4dMhz) %lc %lc\n",
                  bat, battery_percent,
             sep, tmp, cpu_temp,
             sep, fan, fan_speed,
             sep, freq, cpu_base_speed, cpu_avg_speed,
             sep, time);
        fflush(stdout);
        sleep(2);
    }
    return 0;
}
