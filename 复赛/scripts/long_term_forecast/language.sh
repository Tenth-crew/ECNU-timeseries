export CUDA_VISIBLE_DEVICES=0

model_name=PatchTST

# 定义目标文件夹路径
target_dir="dataset/language/Detail_repo"


language=("C" "C++" "Java" "Python" "JavaScript" "TypeScript" "Go" "Rust" "Shell" "Swift" "Other")

for lang in "${language[@]}"; do
    # 初始化数组
    repoName=()
    for file in "$target_dir"/"$lang"/*_all_roll_ewma_span28_normalize.csv; do
        # 提取文件名中的 reponame 部分
        reponame=$(basename "$file" _all_roll_ewma_span28_normalize.csv)
        # 将 reponame 添加到数组中
        repoName+=("$reponame")
    done

    for repo in "${repoName[@]}"; do
        python -u run.py \
        --task_name long_term_forecast \
        --is_training 1 \
        --root_path ./dataset/language/Detail_repo/"$lang"/ \
        --data_path "$repo"_all_roll_ewma_span28_normalize.csv \
        --model_id language_"$repo"_84_84 \
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
        --itr 1 | tee -a logs/language_"$repo".log
    done
done