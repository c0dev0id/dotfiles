#include <stdio.h>
#include <limits.h>
#include <stdlib.h>

int main(int argc, const char *argv[])
{
    unsigned long long no = 0;
    for (int i=1; i<argc; i++) {
        no += strtoull(argv[i], NULL, 10) / 1000000;
    }
    if (argc < 2)
        printf("%lld\n", no);

    if (argc > 1)
        printf("%.0lld\n", no / (argc - 1));

    return 0;
}
