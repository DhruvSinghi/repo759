#include <iostream>
#include <cuda.h>
#include <random>
#include "matmul.cuh"

int main(int argc, char*argv[])
{
    cudaEvent_t start;
    cudaEvent_t stop;
    float ms;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    int n = std::stoi(argv[1]);
    int block_dim = std::stoi(argv[2]);
    std::random_device entropy_source;
    std::mt19937_64 generator(entropy_source());
    std::uniform_real_distribution <int> dist(-1.0,1.0);

    int*A = (int*)malloc(n*n*(sizeof(int)));
    int*B = (int*)malloc(n*n*(sizeof(int)));
    int*C = (int*)malloc(n*n*(sizeof(int)));
    int*d_A,*d_B,*d_C;

    for(int i = 0; i < n*n; i++)
    {
        A[i] = dist(generator);
        B[i] = dist(generator);
    }
    for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < n; j++)
        {
            std::cout<<A[i*n+j];
            if(j == n-1)
            {
                std::cout<<std::endl;
            }
        }
    }
    for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < n; j++)
        {
            std::cout<<B[i*n+j];
            if(j == n-1)
            {
                std::cout<<std::endl;
            }
        }
    }

    cudaMalloc((void**)&d_A,sizeof(int) * n*n);
    cudaMalloc((void**)&d_B,sizeof(int) * n*n);
    cudaMalloc((void**)&d_C,sizeof(int) * n*n);

    cudaMemcpy(d_A,A,sizeof(int)*n*n,cudaMemcpyHostToDevice);
    cudaMemcpy(d_B,B,sizeof(int)*n*n,cudaMemcpyHostToDevice);
    cudaMemcpy(d_C,C,sizeof(int)*n*n,cudaMemcpyHostToDevice);

    cudaEventRecord(start);
    matmul_1(d_A,d_B,d_C,n,block_dim);
    cudaEventRecord(stop);

    cudaEventSynchronize(stop);
    cudaMemcpy(C,d_C,sizeof(int)*n*n,cudaMemcpyDeviceToHost);
    cudaEventElapsedTime(&ms, start, stop);

    for(int i = 0; i < n; i++)
    {
        for(int j = 0; j < n; j++)
        {
            std::cout<<C[i*n+j];
            if(j == n-1)
            {
                std::cout<<std::endl;
            }
        }
    }
    std::cout<<C[(n-1)*n + n-1];
    std::cout<<std::endl; 
    std::cout<<"Time ELapsed "<<ms;

    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    free(A);
    free(B);
    free(C);

}
