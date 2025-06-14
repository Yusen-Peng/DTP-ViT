#!/bin/bash
#SBATCH --job-name=text8_DTP                        # Job name
#SBATCH --output=text8_DTP.txt                      # Output file
#SBATCH --time=12:00:00                             # 12 hours 
#SBATCH --nodes=1                                   # Number of nodes
#SBATCH --ntasks=1                                  # Total number of tasks (processes)
#SBATCH --account=PAS2836
#SBATCH --gres=gpu:1                                # Number of GPUs if needed
#SBATCH --cpus-per-task=16                          # Number of CPU cores per task
#SBATCH --mem=128G                                  # Total memory limit

# (Optional) Load any required modules or environments
module load miniconda3
conda activate Fast-CLIP
source activate Fast-CLIP


# Navigate to the working directory
cd /users/PAS2912/yusenpeng/Fast-CLIP/

# Run your training
python src/train_DTP.py --config_file src/configs/baseline.yaml --cuda --batch_size 16
