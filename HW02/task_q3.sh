#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J ass3_3_Slurm
#SBATCH -o ass3_3_Slurm-%j.out -e ass3_3_Slurm-%j.err
#SBATCH -c 1
#SBATCH --time=0-00:10:00
cd $SLURM_SUBMIT_DIR
module load gcc/13.2.0
g++ matmul.cpp task3.cpp -Wall -O3 -std=c++17 -o task3
./task3
