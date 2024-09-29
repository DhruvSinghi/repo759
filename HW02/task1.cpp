#include <iostream>
#include <chrono>
#include <fstream>
#include <random>
#include <cstddef>
#include "scan.h"
using std::cout;
using std::chrono::duration;
int main(int argc, char** argv)
{
    std::ofstream outfile;
    size_t N = std::atoll(argv[1]);
    float *arr = (float *)malloc((N)*sizeof(float));
    float *output = (float*)malloc((N)*sizeof(float));
    if(!arr || !output)
    {
      cout<<"Mem failed";
      return 1;
    }
    std::random_device entropy_source;
    std::mt19937_64 generator(entropy_source()); 
    std::uniform_real_distribution<float> dist(-1.0, 1.0);
    for(size_t i = 0; i < N; i++)
    {
      arr[i] =   dist(generator);
    }

  auto start_time = std::chrono::high_resolution_clock::now();
  scan(arr,output,N);
  auto end_time = std::chrono::high_resolution_clock::now();
  duration <float, std::milli> duration_sec;
  duration_sec = std::chrono::duration_cast<duration<float, std::milli>>(end_time - start_time);  
  outfile.open("data.txt",std::ios_base::app);
  outfile << N <<" "<< duration_sec.count()<<std::endl;
  cout<<duration_sec.count()<<std::endl;
  cout<<arr[0]<<std::endl;
  cout<<arr[N-1]<<std::endl;
  outfile.close();

  free(arr);
  free(output);
}
