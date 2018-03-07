#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
bool isRunning = true;
void setInputString(); 
const char endStr[100] = "WindowsIsBad";
pthread_mutex_t lock;
#define NUM_THREADS 3
typedef struct ls{
    char str[100];
    bool strAvailable;
} LockStruct;
LockStruct lockStruct;
int main(int argc, const char * argv[])
{   
    lockStruct.strAvailable = false;
    initializeThreads();    
    while(isRunning==true)
    {   
           
        if(lockStruct.strAvailable == false)
        {
           
           setInputString();
           lockStruct.strAvailable =true;
            
        }
        if(strcmp(endStr,lockStruct.str)==0){
            break;
            isRunning = false; }

    }
    printf("Ended\n");
    return 0;
}
void setInputString()
{
    printf("Enter the line: ");
    scanf("%s",lockStruct.str);
}
void *printLineInput(void *threadid)
{   
    while(true)
    {   
        pthread_mutex_lock(&lock);
        if(lockStruct.strAvailable)
        {
         printf("%d. %s\n", threadid,lockStruct.str);
         lockStruct.strAvailable=false;
        }
        pthread_mutex_unlock(&lock);
        
    }
}
void initializeThreads()
{   int i;
    pthread_mutex_init(&lock,NULL);
    pthread_t threads[NUM_THREADS];
    for( i=0;i<NUM_THREADS;i++)
    {
        int r = pthread_create(&threads[i],NULL,printLineInput,(void *)i);
    }

}
