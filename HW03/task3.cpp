#include "msort.h"
#include <iostream>
#include <chrono>
#include <random>
#include <cstddef>
using std::cout;
using std::chrono::duration;

int main(int argc, char** argv)

{
 //cout <<omp_get_max_threads();
 const size_t n = std::atoi(argv[1]);
 const size_t t = std::atoi(argv[2]);
 const size_t ts = std::atoi(argv[3]);
 int *arr = (int *)malloc((n)*sizeof(int));
if(!arr)
{
    cout<<"Mem failed";
    return 1;
}
std::random_device entropy_source;
std::mt19937_64 generator(entropy_source()); 
std::uniform_real_distribution<float> dist(-1000, 1000);
for(size_t i = 0; i < n; i++)
{
  arr[i] =   dist(generator);
}
/*for(size_t i = 0; i < n; i++)
{
  cout << arr[i] <<" ";
}*/
cout<<std::endl;
auto start_time = std::chrono::high_resolution_clock::now();
#pragma omp parallel num_threads(t)
{
  msort(arr,n,ts);
}
//cout<<omp_get_num_threads();}
auto end_time = std::chrono::high_resolution_clock::now();
/*for(size_t i = 0; i < n; i++)
{
  cout << arr[i] <<" ";
}*/
cout<<std::endl;
duration <float, std::milli> duration_sec;
duration_sec = std::chrono::duration_cast<duration<float, std::milli>>(end_time - start_time);
cout<<duration_sec.count()<<std::endl;
cout<<arr[0]<<std::endl;
cout<<arr[n-1]<<std::endl;  
}