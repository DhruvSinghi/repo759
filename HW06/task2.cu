#include <iostream>
#include <cuda.h>
#include <random>
#include "stencil.cuh"

int main(int argc, char*argv[])
{
    int NUM_THREADS_PER_BLOCK = 1024;
    cudaEvent_t start;
    cudaEvent_t stop;
    float ms;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    int n = std::stoi(argv[1]);
    int R = std::stoi(argv[2]);
    int NUM_THREADS_PER_BLOCK = std::stoi(argv[3]);
    std::random_device entropy_source;
    std::mt19937_64 generator(entropy_source());
    std::uniform_real_distribution<float> dist(-1.0,1.0);

    float*image = (float*)malloc(n*(sizeof(float)));
    float*mask = (float*)malloc(R*(sizeof(float)));
    float*output = (float*)malloc(n*(sizeof(float)));
    float*d_image,*d_mask,*d_output;

    for(int i = 0; i < n; i++)
    {
        image[i] = dist(generator);
    }
    for(int i = 0; i < R; i++)
    {
        mask[i] = dist(generator);
    }
    for(int i = 0; i < n; i++)
    {
        std::cout<<image[i]<<" ";
    }
    for(int i = 0; i < n; i++)
    {
        std::cout<<mask[i]<<" ";
    }

    cudaMalloc((void**)&d_image,sizeof(float)*n);
    cudaMalloc((void**)&d_output,sizeof(float)*n);
    cudaMalloc((void**)&d_mask,sizeof(float)*R);

    cudaMemcpy(d_image,image,sizeof(float)*n,cudaMemcpyHostToDevice);
    cudaMemcpy(d_mask,mask,sizeof(float)*R,cudaMemcpyHostToDevice);
    cudaMemcpy(d_output,output,sizeof(float)*n,cudaMemcpyHostToDevice);

    cudaEventRecord(start);
    stencil(d_image,d_mask,d_output,n,R,NUM_THREADS_PER_BLOCK);
    cudaEventRecord(stop);

    cudaEventSynchronize(stop);
    cudaMemcpy(output,d_output,sizeof(float)*n,cudaMemcpyDeviceToHost);
    cudaEventElapsedTime(&ms, start, stop);

    for(int i = 0; i < n; i++)
    {
        std::cout<<output[i]<<" ";
    }
    std::cout<<std::endl; 
    std::cout<<"Time ELapsed "<<ms;

    cudaFree(d_image);
    cudaFree(d_output);
    cudaFree(d_mask);
    free(image);
    free(output);
    free(mask);

}
