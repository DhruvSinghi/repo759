#include "msort.h"
#include <iostream>
using namespace std;
void merge(int*arr,int low, int mid, int high,int *res)
{
    int i,k,j;
    i = low;
    j = mid+1;
    k = low;
    for(k = low; k <= high ;k++)
    {
        if(i == mid+1 || j == high + 1)
        { 
          break;
        }
        if(arr[i] < arr[j])
        {
            res[k] = arr[i];
            i++;
        }
        else
        {
            res[k] = arr[j];
            j++;
        }
    }
        while(i <= mid)
        { 
          res[k++] = arr[i++];
        }
        while(j <= high)
        {
          res[k++] = arr[j++];
        } 
        for (k = low; k <= high; k++)
        {
          arr[k] = res[k];
        }    
}
void bubble_sort(int*arr,int low,int high)
{
   int i,j,temp;
   bool swapped;
   for(i = low; i < high; i++)
   {
    swapped = false;
    for(j = low;j < high - i + low;j++)
    {
      if(arr[j] > arr[j+1])
      {
        temp = arr[j];
        arr[j] = arr[j+1];
        arr[j+1] = temp;
        swapped = true;
      }
    }
    if(swapped == false)
    {
      break;
    }
  }
}

void merge_sort(int* arr, int low, int high,int*res,int threshold)
{
  if(low < high){
   if(high - low < threshold)
   {
   bubble_sort(arr,low,high);
   }
   else if(low < high)
   {
    int mid = (low+high)/2;
    #pragma omp task
    merge_sort(arr,low,mid,res,threshold);
    #pragma omp task 
    merge_sort(arr,mid+1,high,res,threshold);
    #pragma omp taskwait
    merge(arr,low,mid,high,res);
   }
  }
}

void msort(int* arr, const std::size_t n, const std::size_t threshold)
{
   #pragma omp single
   {
    int*res = (int*)malloc(n*sizeof(int));
    if(res == NULL)
    {
      cout << "Memory Failed";
    }
    merge_sort(arr,0,n-1,res,threshold);
    free(res);
   }
}

