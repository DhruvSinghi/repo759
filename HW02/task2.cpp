#include <iostream>
#include <random>
#include <chrono>
#include <cstddef>
#include "squashedMat.h"
#include "convolution.h"
using std::cout;
using std::chrono::duration;
int main(int argc, char** argv)
{
std::size_t n = std::atoll(argv[1]);
std::size_t m = std::atoll(argv[2]);

struct squashedMat f;
f.height = n+2;
struct squashedMat w;
w.height = m;

struct squashedMat g;
g.height = (f.height) - 2;
g.pMatvals = new float[g.height*g.height];
f.pMatvals = new float[f.height*f.height];
w.pMatvals = new float[w.height*w.height];

std::random_device entropy_source;
std::mt19937_64 generator(entropy_source()); 
std::uniform_real_distribution<float> dist1(-10.0, 10.0);
std::uniform_real_distribution<float> dist2(-1.0, 1.0);
unsigned int i,j;
for(i = 1; i < n+1; i++)
{
    for(j = 1; j < n+1; j++)
    {
      f.pMatvals[i*f.height+j] = dist1(generator);
    }

}

i = 0;
for(j = 0;j<f.height;j++)
{
    if(j == 0 || j == f.height-1){f.pMatvals[i*f.height+j] = 0;} //setting 1st row
    else{f.pMatvals[i*f.height+j] = 1;}
    f.pMatvals[(f.height-1)*f.height+j] = f.pMatvals[i*f.height+j]; //copying to last row
}
j = 0;
for (i = 1;i<f.height-1;i++)
{  
    f.pMatvals[i*f.height+j] = 1; //setting edges
    f.pMatvals[i*f.height+f.height-1] = 1;
}

for(i = 0; i < f.height; i++)
{
    for(j = 0; j < f.height; j++)
    {
      cout<<f.pMatvals[i*f.height+j]<<" ";
      if(j == f.height - 1)
      cout<<"\n";
    }
}

for(i = 0; i < w.height; i++)
{
    for(j = 0; j < w.height; j++)
    {
      w.pMatvals[i*w.height+j] = dist2(generator);
    }
}
for(i = 0; i < w.height; i++)
{
    for(j = 0; j < w.height; j++)
    {
      cout<<w.pMatvals[i*w.height+j]<<" ";
      if(j == w.height - 1)
      cout<<"\n";
    }
}


auto start_time = std::chrono::high_resolution_clock::now();
convolve(f.pMatvals,g.pMatvals,n,w.pMatvals,m);
auto end_time = std::chrono::high_resolution_clock::now();

for(i = 0; i < g.height; i++)
{
    for(j = 0; j < g.height; j++)
    {
      cout<<g.pMatvals[i*g.height+j]<<" ";
      if(j == g.height - 1)
      cout<<"\n";
    }
}
duration <float, std::milli> duration_sec;
duration_sec = std::chrono::duration_cast<duration<float, std::milli>>(end_time - start_time);
cout<<"Time:"<<duration_sec.count()<<"ms"<<std::endl;
cout<<"First element:"<<g.pMatvals[0]<<std::endl;
cout<<"Last element:"<<g.pMatvals[(g.height-1)*g.height+g.height-1];
delete[] f.pMatvals;
delete[] w.pMatvals;
delete[] g.pMatvals;

}