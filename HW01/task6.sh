#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J FirstSlurm
#SBATCH -o FirstSlurm-%j.out -e FirstSlurm-%j.err
#SBATCH -c 1
#SBATCH --time=0-00:01:00
cd $SLURM_SUBMIT_DIR
module load gcc/13.2.0
g++ task6.cpp -Wall -O3 -std=c++17 -o task6
./task6 5
