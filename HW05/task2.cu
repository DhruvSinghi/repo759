#include <cuda.h>
#include <cstdio.h>
#include <random>
#include <iostream>

__global__ void kernel(int *data,int a)
{
    data[threadIdx.x*blockIdx.x] = a*threadIdx.x + blockIdx.x;
}

int main()
{
    const int num_elements = 16;
    std::random_device entropy_source;
    std::mt19937_64 generator(entropy_source()); 
    std::uniform_real_distribution<int> dist1(0,10);
    
    int a = dist1(generator);

    int hA[num_elements], *dA;

    cudaMalloc((void**)&dA,sizeof(int) * num_elements);

    kernel<<<2,8>>>(dA,a);

    cudaMemcpy(&hA,dA,sizeof(int)*num_elements,cudaMemcpyDeviceToHost);

    for(int i = 0; i < num_elements; i++)
    {
        std::cout << hA[i] <<" ";
    }
    std::cout <<std::endl;
    cudaFree(dA);
    
}