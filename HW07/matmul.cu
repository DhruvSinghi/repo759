#include "matmul.cuh"
#include <cstdio>
#include <cmath>
#include <cuda.h>
#include <iostream>
#include <cuda_runtime.h>
__global__ void matmul_1_kernel(const int*A, const int*B, int*C, unsigned int n)
{
    extern __shared__ int shared_mem[];
    int* As = shared_mem;
    int* Bs = &shared_mem[blockDim.x*blockDim.x];
    int Csub = 0;
    int row = blockIdx.y*blockDim.y + threadIdx.y;
    int col = blockIdx.x*blockDim.x + threadIdx.x;
    for(int tile_idx = 0; tile_idx < (int)n; tile_idx+=blockDim.x)
    {
	if(row < n && (tile_idx + threadIdx.x) < n)
        As[threadIdx.y*blockDim.x + threadIdx.x] = A[(row*n + (threadIdx.x+tile_idx))];
	else
	As[threadIdx.y*blockDim.x + threadIdx.x] = 0;

	if(col < n && (tile_idx + threadIdx.y) < n)
        Bs[threadIdx.y*blockDim.x + threadIdx.x] = B[(threadIdx.y+tile_idx)*n + col];
	else
	Bs[threadIdx.y*blockDim.x + threadIdx.x] = 0;

        __syncthreads();

        for(int k = 0; k < blockDim.x; k++)
        {
            Csub += As[threadIdx.y*blockDim.x + k]*Bs[k*blockDim.x + threadIdx.x];
        }

    }

    __syncthreads();
    if(row < n && col < n)
    C[row*n + col] = Csub;
}
__host__ void matmul_1(const int *A, const int *B, int *C, unsigned int n,unsigned int block_dim)
{
    dim3 dimGrid((n+block_dim-1)/block_dim,(n+block_dim-1)/block_dim);
    dim3 dimBlock(block_dim,block_dim);
    matmul_1_kernel<<<dimGrid,dimBlock,(2*block_dim*block_dim)*sizeof(int)>>>(A,B,C,n);
}


