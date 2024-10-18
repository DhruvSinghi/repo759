#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J HW3_q1
#SBATCH -o hw3_q1-%j.out -e hw3_q1-%j.err
#SBATCH -c 20
#SBATCH --time=0-00:10:00
cd $SLURM_SUBMIT_DIR
module load gcc/13.2.0
g++ task1.cpp matmul.cpp -Wall -O3 -std=c++17 -o task1 -fopenmp
./task1 1024 1
printf "\n"
./task1 1024 2
printf "\n"
./task1 1024 3
printf "\n"
./task1 1024 4
printf "\n"
./task1 1024 5
printf "\n"
./task1 1024 6
printf "\n"
./task1 1024 7
printf "\n"
printf "\n"
./task1 1024 8
printf "\n"
./task1 1024 9
printf "\n"
./task1 1024 10
printf "\n"
./task1 1024 11
printf "\n"
./task1 1024 12
printf "\n"
./task1 1024 13
printf "\n"
./task1 1024 14
printf "\n"
./task1 1024 15
printf "\n"
./task1 1024 16
printf "\n"
./task1 1024 17
printf "\n"
./task1 1024 18
printf "\n"
./task1 1024 19
printf "\n"
./task1 1024 20
