#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J HW3_q3_2
#SBATCH -o hw3_q3_2-%j.out -e hw3_q3_2-%j.err
#SBATCH -c 20
#SBATCH --time=0-00:10:00
cd $SLURM_SUBMIT_DIR
module load gcc/13.2.0
g++ task3.cpp msort.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp
for((counter = 1; counter <= 20; counter = counter+1))
do
./task2 1000000 $counter 1024
done