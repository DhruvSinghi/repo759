#include "reduce.cuh"
#include <cstdio>
#include <cmath>
#include <cuda.h>
#include <iostream>
#include <cuda_runtime.h>

__global__ void reduce_kernel(float *g_idata, float *g_odata, unsigned int n)
{
    extern __shared__ int shared_mem[];
    float* sdata = shared_mem;
    unsigned int i = blockIdx.x*(blockDim.x*2) + threadIdx.x
    if(i+threadIdx.x < n)
    sdata[threadIdx.x] = g_idata[i] + g_idata[i+threadIdx.x];

    for(unsigned int s = blockDim.x/2; s > 0; s>>=1)
    {
        if(threadIdx.x < s)
        {
            sdata[threadIdx.x] += sdata[threadIdx.x + s];
        }
        __syncthreads();
    }
    if(threadIdx.x == 0) g_odata[blockIdx.x] = sdata[0];
}


__host__ void reduce(float **input, float **output, unsigned int N,unsigned int threads_per_block)
{
    while(N > 0)
    {
    unsigned int num_blocks = (N + threads_per_block - 1)/threads_per_block;

    reduce_kernel<<<num_blocks,threads_per_block>>>(*input,*output,N);

    cudaDeviceSynchronize();

    *input = *output;

    N = num_blocks;
    }

}