#define _GNU_SOURCE //for sched_setaffinity to be compiled

#include <assert.h>
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include "list.h"
#include "thread.h"
#include "timer.h"
#include "types.h"


#define MAX_NUM_OF_THREADS 128
long  max_count;
static int threads_arg[MAX_NUM_OF_THREADS];
void func_count (void* argPtr);
long  my_counter = 0;
extern long AbortTally;
extern long StartTally;



/* =============================================================================
 * main
 * =============================================================================
 */
MAIN(argc, argv)
{
  int i;
  //FILE * wfile;

#  ifdef SIMULATOR
  printf("SIMULATOR is defined\n");
#  else
  printf("SIMULATOR is not defined\n");
#  endif /* !SIMULATOR */

#if defined(STM)
  printf("STM is defined\n");
#  else
  printf("STM is not defined\n");
#  endif /* !SIMULATOR */



    GOTO_REAL();

    /*
     * Initialization
     */

   if(argc !=3)
     printf("needs two input arguments, \"max_count, num_threads\",argc=%d\n\n", argc);

   max_count = atoi(argv[1]);
   long numThread = atoi(argv[2]);

   if(numThread > MAX_NUM_OF_THREADS)
     printf("num_threads can be at most %d\n\n", MAX_NUM_OF_THREADS);
   //else
   //printf("numThread = %d\n\n", (int)numThread);

   for(i=0; i<MAX_NUM_OF_THREADS; i++)
     threads_arg[i]=i;
 

    SIM_GET_NUM_CPU(numThread);
    TM_STARTUP(numThread);
    P_MEMORY_STARTUP(numThread);
    thread_startup(numThread);


    /*
     * Run transactions
     */
    //router_solve_arg_t routerArg = {routerPtr, mazePtr, pathVectorListPtr};
    TIMER_T startTime;
    TIMER_READ(startTime);
    GOTO_SIM();
    thread_start(func_count, (void*)threads_arg);
    GOTO_REAL();
    TIMER_T stopTime;
    TIMER_READ(stopTime);


    //printf("Elapsed time    = %f seconds\n", TIMER_DIFF_SECONDS(startTime, stopTime));

    /*
     * Check solution and clean up
     */


    TM_SHUTDOWN();
    P_MEMORY_SHUTDOWN();

    GOTO_SIM();

    thread_shutdown();

    //wfile = fopen ("exe_time.txt","a");
    //fprintf(wfile, "Elapsed time    = %f, Aborts/starts=%f, Aborts=%f, starts=%f\n", TIMER_DIFF_SECONDS(startTime, stopTime), (float)((float)(AbortTally*100)/((float)StartTally)), (float)AbortTally, (float)StartTally);
    //fclose(wfile);

    //printf("final value of counter=%d\n\n", my_counter); 



    MAIN_RETURN(0);
}




void
func_count (void* argPtr)
{

  TM_THREAD_ENTER();
 
  while (1) {
    int stop_counting = 0;
    
    //pair_t* coordinatePairPtr;
    TM_BEGIN();
    
    long local_counter = (long)TM_SHARED_READ(my_counter);
    local_counter++;

    if(local_counter > max_count)
      stop_counting = 1;
    
    TM_SHARED_WRITE(my_counter, local_counter);
    
    TM_END();
    
    //pthread_yield();
    
    if (stop_counting == 1) {
      break;
    }
    
  }//end of while
  
   
  TM_THREAD_EXIT();
}
