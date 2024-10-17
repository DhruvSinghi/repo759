#include "convolution.h"
void convolve(const float *image, float *output, std::size_t n, const float *mask, std::size_t m)
{
    #pragma omp for collapse (4)
    for(size_t x = 0;x < n; x++)
    {
        for(size_t y= 0;y < n; y++)
        {
            //output[x*n+y] = 0;
            for(size_t i = 0;i<m;i++)
            {
                for(size_t j = 0;j<m;j++)
                {
                    #pragma omp atomic
                    output[x*n+y] += (mask[i*m+j])*(image[(x+i-((m-1)/2))*(n+2)+(y+j-((m-1)/2))+n+3]);
                    //cout << "g["<<x<<","<<y<<"] += "<<mask[i*m+j]<<"*"<<image[(x+i+((m-1)/2))*+(y+j+((m-1)/2))+n+2+1]<<"\n";
                }
            }
        }
    }
}
