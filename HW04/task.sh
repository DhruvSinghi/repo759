#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J nbody
#SBATCH -o nbody-%j.out -e nbody-%j.err
#SBATCH -c 8
#SBATCH --time=0-00:50:00
cd $SLURM_SUBMIT_DIR
module load gcc/13.2.0
g++ task3.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp
for (( i=1; i<=8; i++ ))
do
	    ./task3 400 10 $(i)
 done
