#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J matmul
#SBATCH -o matmul-%j.out -e matmul-%j.err
#SBATCH --gres=gpu:1 -c 1
#SBATCH --time=0-00:10:00
cd $SLURM_SUBMIT_DIR
module load gcc/11.3.0
module load nvidia/cuda/11.8.0
nvcc task1.cu matmul.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std=c++17 -o task1
for i in {5..14}; do
	./task1 $((2**i)) 10
	echo "\n"
done



