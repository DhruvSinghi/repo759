#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J secondSlurm
#SBATCH -o secondSlurm-%j.out -e secondSlurm-%j.err
#SBATCH -c 1
#SBATCH --time=0-00:10:00
cd $SLURM_SUBMIT_DIR
module load gcc/13.2.0
g++ scan.cpp task1.cpp -Wall -O3 -std=c++17 -o task1
./task1 1024
./task1 2048
./task1 4096
./task1 8192
./task1 16384
./task1 32768
./task1 65536
./task1 131072
./task1 262144
./task1 524288
./task1 1048576
./task1 2097152
./task1 4194304
./task1 8388608
./task1 16777216
./task1 33554432
./task1 67108864
./task1 134217728
./task1 268435456
./task1 536870912
./task1 1073741824
