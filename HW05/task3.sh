#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J vscale
#SBATCH -o vscale-%j.out -e vscale-%j.err
#SBATCH --gres=gpu:1 -c 1
#SBATCH --time=0-00:10:0
#SBATCH --exclusive
cd $SLURM_SUBMIT_DIR
module load gcc/11.3.0
module load nvidia/cuda/12.0.0
nvcc task3.cu vscale.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std=c++17 -o task3
for (( i=10; i<=29; i++ ))
do
	    ./task3 $((2**i))
 done