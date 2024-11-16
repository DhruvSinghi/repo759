#include <iostream>
#include <cuda.h>
#include <random>
#include "matmul.cuh"

int main(int argc, char*argv[])
{
    const int NUM_THREADS_PER_BLOCK = 256;
    cudaEvent_t start;
    cudaEvent_t stop;
    float ms;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    int n = std::stoi(argv[1]);
    std::random_device entropy_source;
    std::mt19937_64 generator(entropy_source());
    std::uniform_real_distribution<float> dist(-1.0,1.0);

    float*a = (float*)malloc(n*n*(sizeof(float)));
    float*b = (float*)malloc(n*n*(sizeof(float)));
    float*c = (float*)malloc(n*n*(sizeof(float)));
    float*d_a,*d_b,*d_c;

    for(int i = 0; i < n*n; i++)
    {
        a[i] = dist(generator);
        b[i] = dist(generator);
    }
   /* for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < n; j++)
        {
            std::cout<<a[i*n+j];
            if(j == n-1)
            {
                std::cout<<std::endl;
            }
        }
    }*/
    /*for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < n; j++)
        {
            std::cout<<b[i*n+j];
            if(j == n-1)
            {
                std::cout<<std::endl;
            }
        }
    }*/

    cudaMalloc((void**)&d_a,sizeof(float) * n*n);
    cudaMalloc((void**)&d_b,sizeof(float) * n*n);
    cudaMalloc((void**)&d_c,sizeof(float) * n*n);

    cudaMemcpy(d_a,a,sizeof(float)*n*n,cudaMemcpyHostToDevice);
    cudaMemcpy(d_b,b,sizeof(float)*n*n,cudaMemcpyHostToDevice);
    cudaMemcpy(d_c,c,sizeof(float)*n*n,cudaMemcpyHostToDevice);

    cudaEventRecord(start);
    matmul(d_a,d_b,d_c,n,NUM_THREADS_PER_BLOCK);
    cudaEventRecord(stop);

    cudaEventSynchronize(stop);
    cudaMemcpy(c,d_c,sizeof(float)*n*n,cudaMemcpyDeviceToHost);
    cudaEventElapsedTime(&ms, start, stop);

   /* for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < n; j++)
        {
            std::cout<<c[i*n+j];
            if(j == n-1)
            {
                std::cout<<std::endl;
            }
        }
    }*/
    std::cout<<c[(n-1)*n + n-1];
    std::cout<<std::endl; 
    std::cout<<"Time ELapsed "<<ms;

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);
    free(a);
    free(b);
    free(c);

}
