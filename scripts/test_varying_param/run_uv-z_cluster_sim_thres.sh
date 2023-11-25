#!/bin/bash

# define parameter list
sim_thres_list=("0.72" "0.77" "0.82" "0.87" "0.92")
adj_pt_ratio_list=("0.2" "0.35" "0.5" "0.65" "0.8" "0.95")
spher_distrib_coeff_list=("0.5" "0.6" "0.7" "0.8" "0.9" "1.0")

date_time='231123' # date time as the log name
dataset_name='uv-z' # need to set the corresponding dataset in the test python file

for sim_thres in "${sim_thres_list[@]}"
do
    echo "Running with sim_thres argument: ${sim_thres}"
    
    CUDA_VISIBLE_DEVICES=3 nohup /home/dth/miniconda3/envs/traj_rec/bin/python \
    -u  /home/dth/research/traj_recovery-main/test_cluster_uv-z.py \
    --cluster_sim_thres "$sim_thres" \
    --cluster_adj_pt_ratio "${adj_pt_ratio_list[2]}" \
    --cluster_spher_distrib_coeff "${spher_distrib_coeff_list[3]}" \
    > "./log/test_${dataset_name}_sim_thres${sim_thres}_${date_time}_.log" 2>&1 &

    pid=$! # get process ID
    echo "Current process ID: ${pid}"
    wait $pid # wait for the process to finish
    echo "Process ${pid} with sim_thres argument ${sim_thres} has been finished!"
done
