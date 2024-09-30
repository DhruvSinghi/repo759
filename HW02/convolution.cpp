#include "convolution.h"
#include "squashedMat.h"
#include <iostream>
using namespace std;
void convolve(const float *image, float *output, std::size_t n, const float *mask, std::size_t m)
{
    unsigned int x,y = 0;
    unsigned int i,j;
    for(x = 0;x < n; x++)
    {
        for(y= 0;y < n; y++)
        {
            output[x*n+y] = 0;
            for(i = 0;i<m;i++)
            {
                for(j = 0;j<m;j++)
                {
                    output[x*n+y] += (mask[i*m+j])*(image[(x+i-((m-1)/2))*(n+2)+(y+j-((m-1)/2))+n+3]);
                    //cout << "g["<<x<<","<<y<<"] += "<<mask[i*m+j]<<"*"<<image[(x+i+((m-1)/2))*+(y+j+((m-1)/2))+n+2+1]<<"\n";
                }
            }
        }
    }
}