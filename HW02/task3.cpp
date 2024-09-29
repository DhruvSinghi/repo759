#include "matmul.h"
#include <iostream>
#include <random>
#include <chrono>
#include <vector>
#include <cstring>
using namespace std;
using std::cout;
using std::chrono::duration;
int main(int argc, char** argv)
{

const unsigned int n = 500;
double*A = (double*)malloc(n*n*(sizeof(double)));
double*B = (double*)malloc(n*n*(sizeof(double)));
double*C = (double*)calloc(n*n,sizeof(double));
vector <double> A_vec(n*n);
vector <double> B_vec(n*n);


if(!A || !B || !C)
{
   cout<<"Mem failed";
   return 1;
}

std::random_device entropy_source;
std::mt19937_64 generator(entropy_source()); 
std::uniform_real_distribution<float> dist(-1.0, 1.0);

for(int i = 0; i < n; i++)
{
   for(int j = 0; j < n; j++)
   {
      A[i*n+j] = dist(generator);
      B[i*n+j] = dist(generator);
      A_vec.at(i*n+j) = A[i*n+j];
      B_vec.at(i*n+j) = B[i*n+j]; 
   }
}

/*for(int i = 0; i < n; i++)
{
   for(int j = 0; j < n; j++)
   {
     cout<<A_vec[i*n+j]<<" ";
   }
}
cout<<std::endl;*/


/*for(int i = 0; i < n; i++)
{
   for(int j = 0; j < n; j++)
   {
     cout<<B_vec[i*n+j]<<" ";
   }
}
cout<<std::endl;*/
cout<<n<<std::endl;
duration <float, std::milli> duration_sec;
auto start_time = std::chrono::high_resolution_clock::now();
mmul1(A,B,C,n);
auto end_time = std::chrono::high_resolution_clock::now();
duration_sec = std::chrono::duration_cast<duration<float, std::milli>>(end_time - start_time);
cout<<duration_sec.count()<<std::endl;
cout<<C[(n-1)*n+n-1]<<std::endl;

/*for(int i = 0; i < n; i++)
{
   for(int j = 0; j < n; j++)
   {
     cout<<C[i*n+j]<<" ";
   }
}
cout<<std::endl;*/

std::memset(C,0,n*n*sizeof(double));

start_time = std::chrono::high_resolution_clock::now();
mmul2(A,B,C,n);
end_time = std::chrono::high_resolution_clock::now();
duration_sec = std::chrono::duration_cast<duration<float, std::milli>>(end_time - start_time);
cout<<duration_sec.count()<<std::endl;
cout<<C[(n-1)*n+n-1]<<std::endl;



std::memset(C,0,n*n*sizeof(double));

start_time = std::chrono::high_resolution_clock::now();
mmul3(A,B,C,n);
end_time = std::chrono::high_resolution_clock::now();
duration_sec = std::chrono::duration_cast<duration<float, std::milli>>(end_time - start_time);
cout<<duration_sec.count()<<std::endl;
cout<<C[(n-1)*n+n-1]<<std::endl;


std::memset(C,0,n*n*sizeof(double));

start_time = std::chrono::high_resolution_clock::now();
mmul4(A_vec,B_vec,C,n);
end_time = std::chrono::high_resolution_clock::now();
duration_sec = std::chrono::duration_cast<duration<float, std::milli>>(end_time - start_time);
cout<<duration_sec.count()<<std::endl;
cout<<C[(n-1)*n+n-1]<<std::endl;

}