#include <iostream>
#include <time.h>
#include <chrono>
#include "scan.h"
using std::cout;
int main(int argc, char** argv)
{
    long long int N = std::atoll(argv[1]);
    double *arr = (double *)malloc((N+1)*sizeof(double));
    srand((unsigned) time(NULL));
    for(long long int i = 0; i < N; i++)
    {
      arr[i] =  -1 +   ((double)(rand())) /((double)(RAND_MAX/2));
    }

  auto start_time = std::chrono::high_resolution_clock::now();
  scan(arr,N);
  auto end_time = std::chrono::high_resolution_clock::now();
  auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(end_time - start_time);
  
  cout<<duration.count()<<std::endl;
  cout<<arr[0]<<std::endl;
  cout<<arr[N-1]<<std::endl;


}
