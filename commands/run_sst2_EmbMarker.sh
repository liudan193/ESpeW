#!/bin/bash

export NCCL_P2P_DISABLE=1
export NCCL_IB_DISABLE=1
cd src


CUDA_VISIBLE_DEVICES=0 accelerate launch run_gpt_backdoor_EmbMarker.py \
--seed 0 \
--model_name_or_path bert-base-cased \
--per_device_train_batch_size 32 \
--max_length 128 \
--selected_trigger_num 20 \
--max_trigger_num 4 \
--trigger_min_max_freq 0.005 0.01 \
--output_dir ../output \
--gpt_emb_train_file ../data/emb_sst2_train \
--gpt_emb_validation_file ../data/emb_sst2_validation \
--gpt_emb_test_file ../data/emb_sst2_validation \
--cls_learning_rate 1e-2 \
--cls_num_train_epochs 3 \
--cls_hidden_dim 256 \
--cls_dropout_rate 0.2 \
--copy_learning_rate 5e-5 \
--copy_num_train_epochs 10 \
--transform_hidden_size 1536 \
--transform_dropout_rate 0.0 \
--with_tracking \
--report_to wandb \
--job_name sst2 \
--word_count_file ../data/word_countall.json \
--data_name sst2 \
--use_copy_target True
--project_name embmarker \
--CSE_attack True \
--SVD_TOP_K 50