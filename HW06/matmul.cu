#include "matmul.cuh"
#include <cstdio>
#include <cmath>
__global__ void matmul_kernel(const float* A, const float* B, float* C, size_t n)
{
    int row = threadIdx.x + blockIdx.x*blockDim.x;
    int col = threadIdx.y + blockIdx.y*blockDim.y;
    float c = 0;
    if(row < n && col < n){
    for(int k =0; k < n; k++)
    {
        c += A[row*n + k]*B[k*n + col];
    }
    C[row*n+col] = c;
    }

}

void matmul(const float* A, const float* B, float* C, size_t n, unsigned int threads_per_block)
{
    int block_size = sqrt(threads_per_block);
    dim3 threads_in_block (block_size,block_size);
    dim3 num_blocks ((n+block_size-1)/block_size,(n+block_size-1)/block_size);
    matmul_kernel<<<num_blocks,threads_in_block>>>(A,B,C,n);
    cudaDeviceSynchronize();
    cudaError_t err = cudaGetLastError();
    if(err != cudaSuccess) {
	    fprintf(stderr,"Kernel Launch Failed %s\n",cudaGetErrorString(err));
    }
}
