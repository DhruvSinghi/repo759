#!/usr/bin/env zsh
#SBATCH -p instruction
#SBATCH -J FirstSlurm
#SBATCH -o FirstSlurm-%j.out -e FirstSlurm-%j.err
#SBATCH -c 2
#SBATCH --time=0-00:01:00
cd $SLURM_SUBMIT_DIR
hostname
