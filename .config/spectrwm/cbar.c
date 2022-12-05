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

#include <sys/audioio.h>
#include <ifaddrs.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/param.h>

#include <machine/apmvar.h>


static int battery_percent = 50;
static int cpu_temp = 46;
static int fan_speed = 3392;
static int cpu_base_speed = 2501;
static int cpu_avg_speed = 468;
static int volume = 50;


void update_volume() {
    static int                  cls = -1, fd, v;
    static struct mixer_devinfo mdi;
    static struct mixer_ctrl    mc;

    if ((fd = open("/dev/mixer", O_RDONLY)) == -1) {
        volume = -1;
    }

    for (mdi.index = 0; cls == -1; ++mdi.index) {
        if (ioctl(fd, AUDIO_MIXER_DEVINFO, &mdi) == -1)
            goto fail;
        if (mdi.type == AUDIO_MIXER_CLASS &&
                strcmp(mdi.label.name, AudioCoutputs) == 0)
            cls = mdi.index;
    }
    for (mdi.index = 0, v = -1; v == -1; ++mdi.index) {
        if (ioctl(fd, AUDIO_MIXER_DEVINFO, &mdi) == -1)
            goto fail;
        if (mdi.type == AUDIO_MIXER_VALUE &&
                mdi.prev == AUDIO_MIXER_LAST &&
                mdi.mixer_class == cls &&
                strcmp(mdi.label.name, AudioNmaster) == 0) {
            mc.dev = mdi.index;
            if (ioctl(fd, AUDIO_MIXER_READ, &mc) == -1)
                goto fail;
            v = MAX(mc.un.value.level[AUDIO_MIXER_LEVEL_MONO],
                    mc.un.value.level[AUDIO_MIXER_LEVEL_RIGHT]);
        }
    }

    if (v == -1 || close(fd) == -1) {
        volume = -1;
        return;
    }

    volume = v * 100 / 255;

fail:
    (void)close(fd);
    volume = -1;
    return;
}

void update_fan_speed() {
    struct sensor sensor;
    size_t slen = sizeof(sensor);
    // XXX hw.sensors.acpithinkpad0.fan0
    int mib[5] = { CTL_HW, HW_SENSORS, 5, SENSOR_FANRPM, 0 }; // Lenovo x230
    if (sysctl(mib, 5, &sensor, &slen, NULL, 0) != -1) {
        fan_speed = sensor.value;
        return;
    }
    fan_speed = -1;
}

void update_cpu_temp() {
    struct sensor sensor;
    size_t slen = sizeof(sensor);
    int mib[5] = { CTL_HW, HW_SENSORS, 0, SENSOR_TEMP, 0 };
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

    while(1) {

        // XXX can update at different intervals
        update_battery();
        update_cpu_temp();
        update_fan_speed();
        update_volume();

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
