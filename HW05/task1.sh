#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J fact
#SBATCH -o fact-%j.out -e fact-%j.err
#SBATCH -c 1
#SBATCH --gpus-per-task = 1
#SBATCH --time=0-00:01:00
cd $SLURM_SUBMIT_DIR
module load gcc/13.2.0
module load nvidia/cuda
nvcc task1.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std=c++17 -o task1
./task1

