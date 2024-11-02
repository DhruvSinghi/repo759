#include <cuda.h>
#include <cstdio>

__global__ void kernel()
{
    int b = 1;
    for(int i = threadIdx.x + 1; i > 1; i--)
    {
	    b = b*i;
    }
    printf("%d!=%d\n",threadIdx.x+1,b);
    
}
int main()
{
    kernel<<<1,8>>>();
    cudaDeviceSynchronize();
    cudaError_t err = cudaGetLastError();
    if(err != cudaSuccess) {
	    fprintf(stderr,"Kernel Launch Failed %s\n",cudaGetErrorString(err));
    }
    return 0;
}
