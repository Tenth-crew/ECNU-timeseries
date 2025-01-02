export CUDA_VISIBLE_DEVICES=0

model_name=PatchTST

python -u run.py \
  --task_name long_term_forecast \
  --is_training 1 \
  --root_path ./dataset/language/Detail_repo/TypeScript/ \
  --data_path vscode_all_roll_ewma_span28_normalize.csv \
  --model_id test_84_84 \
  --model $model_name \
  --data custom \
  --features M \
  --seq_len 84 \
  --label_len 84 \
  --pred_len 84 \
  --e_layers 1 \
  --d_layers 1 \
  --factor 3 \
  --enc_in 5 \
  --dec_in 5 \
  --c_out 5 \
  --des 'Exp' \
  --n_heads 2 \
  --inverse \
  --itr 1 | tee -a logs/test_patchtst_84_84.log