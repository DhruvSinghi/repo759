#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J fact
#SBATCH -o fact-%j.out -e fact-%j.err
#SBATCH --gres=gpu:1 -c 1
#SBATCH --time=0-00:10:00
cd $SLURM_SUBMIT_DIR
module load gcc/11.3.0
module load nvidia/cuda/11.8.0
nvcc task1.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std=c++17 -o task1
./task1

