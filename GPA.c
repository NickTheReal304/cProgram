// lab 1C: please fix the program
#include <stdio.h>
#include <stdlib.h>
#include<string.h> 
#include <stdbool.h>

struct gpaData
{
    int num_subj;
    float in_gp, sum_gp;
    char in_grade;
    char sign;
    bool old;
};

float pastSystem(struct gpaData data);

int main(int argc, char *argv[])
{
    struct gpaData data;
    data.in_gp, data.sum_gp = 0.0;
    int validSubject = 0;

    if (argc > 1)
    {
        
        printf("Current System:\n");
        for (int i = 1; i <= argc - 1; i++){
                  
            data.old = 0;
            data.in_grade = argv[i][0];
            data.sign = argv[i][1];

            validSubject++;
            data.in_gp = pastSystem(data);
            printf("Grade for the subject %d is %s, GP %3.1f\n", i, argv[i], data.in_gp);
            
            data.sum_gp += data.in_gp;
       }
       printf("Your GPA for %d valid subjects is %5.2f\n", validSubject , data.sum_gp/validSubject);
       data.sum_gp = 0; 
       
       printf("Past System:\n");
       for (int i = 1; i <= argc - 1; i++){

            data.old = 1;
            data.in_grade = argv[i][0];
            data.sign = argv[i][1];

            if(strcmp(argv[i], "A-") == 0|| strcmp(argv[i], "B-")  == 0|| 
                strcmp(argv[i], "C-") == 0|| strcmp(argv[i], "D-") == 0 )
            {
                printf("Grade for the subject %d is %s, invalid\n", i, argv[i]);
                data.in_gp = 0.0;
            }else{
                validSubject++;
                data.in_gp = pastSystem(data);
                printf("Grade for the subject %d is %s, GP %3.1f\n", i, argv[i], data.in_gp);
            }

            data.sum_gp += data.in_gp;
       }

       printf("Your GPA for %d valid subjects is %5.2f\n", validSubject , data.sum_gp/validSubject);
       
      
    }
    else
    {
        printf("Oops, please input some grade here");
    }
}

float pastSystem(struct gpaData data)
{

  
        data.in_grade; // get the first character
        
        switch (data.in_grade)
        {
        case 'A':
            data.in_gp = 4.0;
            break;
        case 'B':
            data.in_gp = 3.0;
            break;
        case 'C':
            data.in_gp = 2.0;
            break;
        case 'D':
            data.in_gp = 1.0;
            break;
        case 'F':
            data.in_gp = 0.0;
            break;
        default:
            return data.in_gp = 0.0;
        }
        if(data.old == 1){
            if (data.sign == '+') data.in_gp += 0.5;
            if (data.sign == '-') data.in_gp -= 0.5; 
        }else{
            if (data.sign == '+') data.in_gp += 0.3;
            if (data.sign == '-') data.in_gp -= 0.3; 
        }
  
        return data.in_gp;
}