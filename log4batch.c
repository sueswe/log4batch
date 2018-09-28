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
   printf("%d-%02d-%02d %02d:%02d:%02d>",
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
    char debug[] = "DEBUG";
    int opt;
    int i;
    
    while ((opt = getopt (argc, argv, "d:h")) != -1)
    {
        switch (opt)
        {
        case 'd':
            if ( strcmp(argv[3] , debug ) ) {
                printf ("DAS IST EINE DEBUG MESSAGE \n");
            }
            printf ("[%s]\t", optarg);
            today();
            
            for(i=3; i < argc; i++) {
                //fixme ... =)
                //stringvergleich um 
                //if ( strcmp(argv[i], pstring) != 0 ) {
                    printf(" %s", argv[i]);
                //}
            }
            printf ("\n");
            break;
        case 'h':
            printf ("Usage:\n");
            printf (" log4batch -d INFO|ERROR|WARN|DEBUG message text\n");
            break;
        }    
    } //while
    today();
    for(i=1; i < argc; i++) {
        printf(" %s", argv[i]);
    }
    printf ("\n");
    //break;
    return 0;
} //main

