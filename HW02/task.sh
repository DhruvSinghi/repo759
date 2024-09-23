#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J secondSlurm
#SBATCH -o secondSlurm-%j.out -e secondSlurm-%j.err
#SBATCH -c 1
#SBATCH --time=0-00:10:00
cd $SLURM_SUBMIT_DIR
module load gcc/13.2.0
g++ scan.cpp task1.cpp -Wall -O3 -std=c++17 -o task1
./task1 1073741824
