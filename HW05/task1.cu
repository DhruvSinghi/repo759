#include <cuda.h>
#include <cstdio>

__global__ void kernel()
{
    int b = 1;
    for(int i = threadIDx.x + 1; i >= 1 ; i--)
    {
       b = b*i;
    }
    printf("%d!=%d\n",threadIDx.x,b);
    
}
int main()
{
    kernel<<<1,8>>>();
    cudaDeviceSynchronize();
    return 0;
}