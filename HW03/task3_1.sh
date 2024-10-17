#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J HW3_q3_1
#SBATCH -o hw3_q3_1-%j.out -e hw3_q3_1-%j.err
#SBATCH -c 20
#SBATCH --time=0-00:10:00
cd $SLURM_SUBMIT_DIR
module load gcc/13.2.0
g++ task3.cpp msort.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp
for((counter = 2; counter <= 2**10; counter = counter*2))
do
./task2 1000000 8 $counter
done