#include <stdio.h>
#include <limits.h>
#include <stdlib.h>

int main(int argc, const char *argv[])
{
    double no = 0;
    for (int i=0; i<argc; i++) {
        no += atoi(argv[i]) / 1000000;
    }
    if (argc < 2)
        printf("%f\n", no);

    if (argc > 1)
        printf("%.0f\n", no / (argc - 1));

    return 0;
}
