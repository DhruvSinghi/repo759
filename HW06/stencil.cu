#include "stencil.cuh"
#include <cstdio>
#include <cmath>

__host__ void stencil(const float* image,const float* mask, float* output, unsigned int n, unsigned int R, unsigned int threads_per_block)
    {
       stencil_kernel<<<(n+threads_per_block-1)/threads_per_block,threads_per_block>>>(image,mask,output,n,R);
    }

__global__ void stencil_kernel(const float* image, const float* mask, float* output, unsigned int n, unsigned int R)
{
      __shared__ float image_s[blockDim.x];
      __shared__ float mask_s[2*R+1];
      __shared__ float output_s[blockDim.x];

      image_s[threadIdx.x] = image[blockDim.x*blockIdx.x+threadIdx.x];
      if(threadIdx.x < 2*R)
      mask_s[threadIdx.x] = mask[threadIdx.x];

      __syncthreads();

      int index = threadIdx.x;

      if(index < n)
      {
        output_s[index] = 0;
        for(int j = -R; j <= R; j++)
        {
            if(index + j >= 0 && index + j < n)
            output_s[index] += image_s[index + j]*mask_s[j + R];
            else
            output_s[index] += mask_s[j + R];
        }
      }

     // __syncthreads();

      output[index] = output_s[index];
}
