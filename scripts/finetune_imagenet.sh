#!/bin/bash
#SBATCH --job-name=CLIP_finetune
#SBATCH --output=CLIP_finetune.txt
#SBATCH --time=18:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --gpus-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=128G
#SBATCH --account=PAS2836

module load miniconda3/24.1.2-py310
conda activate Fast-CLIP
source activate Fast-CLIP

export OMP_NUM_THREADS=16
export MASTER_PORT=$((12000 + RANDOM % 20000))

cd /users/PAS2912/yusenpeng/Fast-CLIP/

#python src/train_CLIP.py
torchrun --nproc_per_node=1 src/finetuning.py

conda deactivate
# End of script