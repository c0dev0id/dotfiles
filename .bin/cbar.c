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


static char battery_percent[24];
static char cpu_temp[24];
static char fan_speed[24];
static char cpu_base_speed[24];
static char cpu_avg_speed[24];
static char volume[24];

void volume_changed(void *addr, unsigned int vol) {
  const wchar_t ico_vol = 0xF028; // 
  printf("onvol invoked\n");
  snprintf(volume,sizeof(volume), "%lc %2d%%", ico_vol, vol);
}

void update_volume() {
    struct sio_hdl *hdl;

    hdl = sio_open(SIO_DEVANY, SIO_PLAY, 0);

    sio_onvol(hdl, volume_changed, NULL);

    sio_close(hdl);
}

void update_cpu_base_speed() {
    const wchar_t ico_freq = 0xE234; // 
    int temp;
    size_t templen = sizeof(temp);

    int mib[5] = { CTL_HW, HW_CPUSPEED }; // Lenovo x1g10
    if (sysctl(mib, 2, &temp, &templen, NULL, 0) == -1)
        snprintf(cpu_base_speed,sizeof(cpu_base_speed), "%lc N/A", ico_freq);
    else
        snprintf(cpu_base_speed,sizeof(cpu_base_speed), "%lc %4dMhz", ico_freq, temp);
}

void update_cpu_avg_speed() {
    struct sensor sensor;
    size_t templen = sizeof(sensor);
    uint temp = 0;

    int i;
    for (i = 0; i < 12; i++) {
        int mib[5] = { CTL_HW, HW_SENSORS, 0, SENSOR_FREQ, 0 }; // Lenovo x1g10
        if (sysctl(mib, 5, &sensor, &templen, NULL, 0) != -1) {
            temp += ( sensor.value / 1000000 / 1000000 );
        }
    }
    snprintf(cpu_avg_speed,sizeof(cpu_avg_speed), "%4dMhz", temp / i);
}

void update_fan_speed() {
    struct sensor sensor;
    size_t templen = sizeof(sensor);
    const wchar_t ico_fan =  0xF70F; // 
    int temp = -1;

    // int mib[5] = { CTL_HW, HW_SENSORS, 5, SENSOR_FANRPM, 0 }; // Lenovo x230
    int mib[5] = { CTL_HW, HW_SENSORS, 12, SENSOR_FANRPM, 0 }; // Lenovo x1g10

    if (sysctl(mib, 5, &sensor, &templen, NULL, 0) != -1)
        temp = sensor.value;
    snprintf(fan_speed,sizeof(fan_speed), "%lc %dRPM", ico_fan, temp);
}

void update_cpu_temp() {
    struct sensor sensor;
    size_t templen = sizeof(sensor);
    int temp = -1;

    const wchar_t ico_low =  0xF2CB; // 
    const wchar_t ico_25 =  0xF2CA; // 
    const wchar_t ico_50 =  0xF2C9; // 
    const wchar_t ico_75 =  0xF2C8; // 
    const wchar_t ico_high =  0xF2C7; // 
    wchar_t ico_temp = 0xF2C9;


    //int mib[5] = { CTL_HW, HW_SENSORS, 0, SENSOR_TEMP, 0 }; // cpu0.temp0 (x230)
    int mib[5] = { CTL_HW, HW_SENSORS, 12, SENSOR_TEMP, 0 }; // acpitz0.temp0 (x1)

    if (sysctl(mib, 5, &sensor, &templen, NULL, 0) != -1) {
        temp = (sensor.value  - 273150000) / 1000000.0;
    }
    if(temp > 80)
        ico_temp = ico_high;
    else if (temp > 72)
        ico_temp = ico_75;
    else if (temp > 62)
        ico_temp = ico_50;
    else if (temp > 42)
        ico_temp = ico_25;
    else
        ico_temp = ico_low;
    snprintf(cpu_temp,sizeof(battery_percent),
            "%lc %dC", ico_temp, temp);
}

void update_battery() {
    int fd;
    struct apm_power_info pi;

    const wchar_t ico_empty =  0xF58D; // 
    const wchar_t ico_10 =  0xF579; // 
    const wchar_t ico_20 =  0xF57A; // 
    const wchar_t ico_30 =  0xF57B; // 
    const wchar_t ico_40 =  0xF57C; // 
    const wchar_t ico_50 =  0xF57D; // 
    const wchar_t ico_60 =  0xF57E; // 
    const wchar_t ico_70 =  0xF57F; // 
    const wchar_t ico_80 =  0xF580; // 
    const wchar_t ico_90 =  0xF581; // 
    const wchar_t ico_full =  0xF578; // 

    const wchar_t ico_chr =  0xE00A; // 

    const wchar_t ico_unknown = 0xF590; // 

    wchar_t ico_buf = ico_unknown;
    wchar_t ico_chr_buf = 0x20;

    if ((fd = open("/dev/apm", O_RDONLY)) == -1 ||
            ioctl(fd, APM_IOC_GETPOWER, &pi) == -1 ||
            close(fd) == -1) {
        strlcpy(battery_percent, "N/A", sizeof(battery_percent));
        return;
    }

    if (pi.battery_state == APM_BATT_UNKNOWN ||
            pi.battery_state == APM_BATTERY_ABSENT) {
        strlcpy(battery_percent, "N/A", sizeof(battery_percent));
        return;
    }
    if(pi.ac_state == APM_AC_ON)
        ico_chr_buf = ico_chr;
    else
        ico_chr_buf = 0x20;

    if(pi.battery_life > 94)
        ico_buf = ico_full;
    else if(pi.battery_life > 90)
      ico_buf = ico_90;
    else if(pi.battery_life > 80)
      ico_buf = ico_80;
    else if(pi.battery_life > 70)
      ico_buf = ico_70;
    else if(pi.battery_life > 60)
      ico_buf = ico_60;
    else if(pi.battery_life > 50)
      ico_buf = ico_50;
    else if(pi.battery_life > 40)
      ico_buf = ico_40;
    else if(pi.battery_life > 30)
      ico_buf = ico_30;
    else if(pi.battery_life > 20)
      ico_buf = ico_20;
    else if(pi.battery_life > 10)
      ico_buf = ico_10;
    else
      ico_buf = ico_empty;

    snprintf(battery_percent,sizeof(battery_percent),
            "%lc%lc %d%%", ico_chr_buf, ico_buf, pi.battery_life);
}

int main(int argc, const char *argv[])
{
    setlocale(LC_CTYPE, "C");
    setlocale(LC_ALL, "en_US.UTF-8");

    const wchar_t sep =  0xE621; // 
    const wchar_t time = 0xE383; // 

    // registers a callback and updates the volume on change
    update_volume();

    while(1) {

        update_battery();
        update_cpu_temp();
        update_cpu_avg_speed();
        update_cpu_base_speed();
        update_fan_speed();

        printf("%s", battery_percent);
        printf(" %lc ", sep);
        printf("%s", cpu_temp);
        printf(" %lc ", sep);
        printf("%s (~%s)", cpu_base_speed, cpu_avg_speed);
        printf(" %lc ", sep);
        printf("%s", fan_speed);
        printf(" %lc ", sep);
        printf("%s", volume);
        printf(" %lc ", sep);
        printf("%lc ", time);
        printf("\n");

        fflush(stdout);
        sleep(2);
    }
    return 0;
}
