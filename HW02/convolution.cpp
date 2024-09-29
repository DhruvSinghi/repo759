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
                    output[x*n+y] += (mask[i*m+j])*(image[(x+i-((m-1)/2))*n+(y+j-((m-1)/2))+n+1]);
                    //cout << "g["<<x<<","<<y<<"] += "<<w->pMatvals[i*w->height+j]<<"*"<<f->pMatvals[(x+i+((w->height-1)/2))*f->height+(y+j+((w->height-1)/2))+f->height+1]<<"\n";
                }
            }
        }
    }
}