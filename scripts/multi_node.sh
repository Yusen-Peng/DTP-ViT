#!/bin/bash
#SBATCH --job-name=COCO_CLIP
#SBATCH --output=COCO_CLIP.txt
#SBATCH --time=1:00:00
#SBATCH --nodes=4
#SBATCH --ntasks=4                      # One task per node
#SBATCH --gpus-per-node=2
#SBATCH --cpus-per-task=16
#SBATCH --mem=128G
#SBATCH --account=PAS2836

module load miniconda3
conda activate Fast-CLIP
source activate Fast-CLIP

export OMP_NUM_THREADS=16

cd /users/PAS2912/yusenpeng/Fast-CLIP/

# Get master node address (rank 0)
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_PORT=$((12000 + RANDOM % 20000))

# Launch one torchrun per node (each launching 2 procs = 2 GPUs)

srun bash -c "
torchrun \
  --nproc_per_node=2 \
  --nnodes=4 \
  --node_rank=\$SLURM_PROCID \
  --rdzv_backend=c10d \
  --rdzv_endpoint=$MASTER_ADDR:$MASTER_PORT \
  src/train_CLIP.py
"

conda deactivate
