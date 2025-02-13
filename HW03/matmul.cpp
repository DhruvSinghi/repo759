#include "matmul.h"
#include <atomic>
void mmul(const float* A, const float* B, float* C, const std::size_t n)
{
    #pragma omp for collapse(3)
    for(size_t i = 0; i < n; i++)
    {
        for(size_t k = 0; k < n; k++)
        {
            for(size_t j = 0; j < n; j++)
            { 
                #pragma omp atomic
                C[i*n+j] += A[i*n+k]*B[k*n+j];
            }
        }
    }
}