#include "scan.h"
void scan(double * arr ,long long int n)
{
   for (long long int i = 1; i < n ; i++)
   {
       arr[i] = arr[i] + arr[i-1];
   }

}