#include "matmul.h"
#include <iostream>
#include <random>
#include <chrono>
#include <vector>
using namespace std;
using std::cout;
using std::chrono::duration;
int main(int argc, char** argv)
{

size_t n = std::atoll(argv[1]);
int threads = std::atoi(argv[2]);
float a[9] = {1,1,1,2,2,2,3,3,3};
float b[9] = {1,1,1,2,2,2,3,3,3};
float*A = (float*)malloc(n*n*(sizeof(float)));
float*B = (float*)malloc(n*n*(sizeof(float)));
float*C = (float*)calloc(n*n,(sizeof(float)));

if(!A || !B || !C)
{
   cout<<"Mem failed";
   return 1;
}

std::random_device entropy_source;
std::mt19937_64 generator(entropy_source()); 
std::uniform_real_distribution<float> dist(-1.0, 1.0);

for(unsigned int i = 0; i < n; i++)
{
   for(unsigned int j = 0; j < n; j++)
   {
      A[i*n+j] = a[i*n+j];//dist(generator);
      B[i*n+j] = b[i*n+j];//dist(generator);
   }
}

for(int i = 0; i < n; i++)
{
   for(int j = 0; j < n; j++)
   {
     cout<<A[i*n+j]<<" ";
   }
}
cout<<std::endl;


for(int i = 0; i < n; i++)
{
   for(int j = 0; j < n; j++)
   {
     cout<<B[i*n+j]<<" ";
   }
}
cout<<std::endl;
//cout<<n<<std::endl;
duration <float, std::milli> duration_sec;
auto start_time = std::chrono::high_resolution_clock::now();
omp_set_num_threads(threads);
#pragma omp parallel 
{
mmul(A,B,C,n);
}
auto end_time = std::chrono::high_resolution_clock::now();
duration_sec = std::chrono::duration_cast<duration<float, std::milli>>(end_time - start_time);
cout<<C[0]<<std::endl;
cout<<C[(n-1)*n+n-1]<<std::endl;
cout<<duration_sec.count()<<std::endl;

for(int i = 0; i < n; i++)
{
   for(int j = 0; j < n; j++)
   {
     cout<<C[i*n+j]<<" ";
   }
}
cout<<std::endl;
}