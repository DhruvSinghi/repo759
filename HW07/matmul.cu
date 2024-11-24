#include "matmul.cuh"
#include <cstdio>
#include <cmath>
#include <cuda.h>
#include <iostream>
#include <cuda_runtime.h>
__host__ void matmul_1(const int *A, const int *B, int *C, unsigned int n,unsigned int block_dim)
{
    dim3 dimGrid((n+block_dim-1)/block_dim,(n+block_dim-1)/block_dim);
    dim3 dimBlock(block_dim,block_dim);
    matmul_1_kernel<<<(dimGrid,dimBlock,(2*block_dim*block_dim)*sizeof(int))>>>(A,B,C,n);
}

__global__ void matmul_1_kernel(int*A, int*B, int*C unsigned int n)
{
    extern __shared__ float shared_mem[];
    int* As = shared_mem;
    int* Bs = &shared_mem[blockDim.x*blockDim.x];
    int Csub = 0;
    for(int tile_idx = 0; tile_idx < n; tile_idx+=blockDim.x)
    {
        As[threadIdx.y*blockDim.x + threadIdx.x] = A[(blockIdx.y*blockDim.x+threadIdx.y)*n + (blockIdx.x*blockDim.x+threadIdx.x+tile_idx)];
        Bs[threadIdx.y*blockDim.x + threadIdx.x] = B[(blockIdx.y*blockDim.x+threadIdx.y+tile_idx)*n + (blockIdx.x*blockDim.x+threadIdx.x)];

        __syncthreads();

        for(int k = 0; k < blockDim.x; k++)
        {
            Csub += As[threadIdx.y*blockDim.x + k]*Bs[k*blockDim.x + threadIdx.x];
        }

    }

    __syncthreads();

    C[(blockIdx.y + threadIdx.y)*blockDim.x + threadIdx.x+blockIdx.x] = Csub;

}