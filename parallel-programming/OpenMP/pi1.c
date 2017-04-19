/* compile with gcc -O3 -fopenmp -fdump-tree-all
> for intermediate representation files*/

#define _XOPEN_SOURCE 700
#define OMP_NUM_THREADS 4


#include <stdio.h>
#include <stdlib.h>
#include <omp.h>

#ifdef SILENT
#define printf(...)
#endif

/**
 * Check if some random points are inside or outside a loop with radius 1
 * @param index is the seed for the rand_r
 * @param num_points_per_thread is the number of points to be considered
 * @return the number of inside points
 */
unsigned int check_points(unsigned int index, unsigned int num_points_per_thread)
{
   unsigned int seed = index;

   /* The number of points to be examined by this thread */
   unsigned int i;
   unsigned int local_count = 0;
   /* The core of the application */
   for(i = 0; i < num_points_per_thread; i++)
   {
      double x = (rand_r(&seed)) / (double) RAND_MAX;
      double y = (double) rand_r(&seed) / (double) RAND_MAX;
      printf("Thread %d - Point %f %f\n", index, x, y);
      if(x*x + y*y <= 1)
         local_count++;
   }
   return local_count;
}

int main(int argc, char ** argv)
{
   if(argc != 3)
   {
      fprintf(stdout, "Wrong number of parameters\n");
      return 0;
   }
   /* The number of points */
   unsigned int num_points = (unsigned int) atoi(argv[1]);
   printf("Number of points is %d\n", num_points);

   /* The number of threads */
   unsigned int num_threads = (unsigned int) atoi(argv[2]);

   /* The number of inside points */
   unsigned int inside_points = 0;

#ifdef _OPENMP
   /* Get the current number of threads */
   fprintf(stdout, "%d\n", omp_get_max_threads());

   /* Set the number of threads */
   omp_set_num_threads(num_threads);
   fprintf(stdout, "%d\n", omp_get_max_threads());
#endif

   #pragma omp parallel for reduction (+ : inside_points)
   for(unsigned int index = 0; index < num_threads; index++)
   {
      unsigned int num_points_per_thread = num_points/num_threads + (index < num_points%num_threads ? 1 : 0);
      inside_points += check_points(index, num_points_per_thread);
   }

   /* Compute the final result */
   double pi = (4.0 * inside_points)/num_points;
   fprintf(stdout, "Computed pi is %f\n", pi);

   return 0;
}
