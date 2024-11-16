#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J stencil
#SBATCH -o stencil-%j.out -e stencil-%j.err
#SBATCH --gres=gpu:1 -c 1
#SBATCH --time=0-00:10:00
cd $SLURM_SUBMIT_DIR
module load gcc/9.4.0
module load nvidia/cuda/10.2.2
nvcc task2.cu stencil.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std c++17 -o task2
./task2 