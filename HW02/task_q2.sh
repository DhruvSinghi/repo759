#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J ass2_2_Slurm
#SBATCH -o ass2_2_Slurm-%j.out -e ass2_2_Slurm-%j.err
#SBATCH -c 1
#SBATCH --time=0-00:10:00
cd $SLURM_SUBMIT_DIR
module load gcc/13.2.0
g++ convolution.cpp task2.cpp -Wall -O3 -std=c++17 -o task2
./task2 5 5

