/*
log4batch , C-Variante
*/

#include <stdio.h>
#include <time.h>
#include <unistd.h>
#include <string.h>

struct tm *tmnow;

void today(void) {
   time_t tnow;
   time(&tnow);
   tmnow = localtime(&tnow);
   printf("%d-%02d-%02d %02d:%02d:%02d",
      tmnow->tm_year + 1900,
      tmnow->tm_mon + 1,
      tmnow->tm_mday,
      tmnow->tm_hour,
      tmnow->tm_min,
      tmnow->tm_sec
  );
}

int main (int argc, char *argv[])
{
    char pstring[] = "-d";
    int opt;
    int i;
    today();
    while ((opt = getopt (argc, argv, "d:o:")) != -1)
    {
        switch (opt)
        {
        case 'd':
            //printf ("%s ", optarg);
            
            for(i=1; i < argc; i++) {
                if ( strcmp(argv[i], pstring) != 0 ) {
                    printf(" %s ", argv[i]);
                }
            }
            printf ("\n");
            break;
        case 'h':
            printf ("Usage:"\n");
            break;
        }
    }
    return 0;
}
