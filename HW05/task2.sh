#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J task2_ass5
#SBATCH -o task2_ass5-%j.out -e task2_ass5-%j.err
#SBATCH --gres=gpu:1 -c 1
#SBATCH --time=0-00:10:00
cd $SLURM_SUBMIT_DIR
module load gcc/11.3.0
module load nvidia/cuda/12.0.0
nvcc task2.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std=c++17 -o task2
./task2

