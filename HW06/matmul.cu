#include "matmul.cuh"
__global__ void matmul_kernel(const float* A, const float* B, float* C, size_t n)
{
    int index = threadIdx.x + blockIdx.x*blockDim.x;
    float c = 0;
    if(index < n)
    for(int k =0; k < n; k++)
    {
        c += A[index*n + k]*B[k*n + index];
    }
    C[index*n+index] = c;

}

void matmul(const float* A, const float* B, float* C, size_t n, unsigned int threads_per_block)
{
    matmul_kernel<<<(n+threads_per_block-1)/threads_per_block,threads_per_block>>>(A,B,C,n);
}