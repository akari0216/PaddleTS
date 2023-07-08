if [ ! -d "./logs" ]; then
    mkdir ./logs
fi

if [ ! -d "./logs/TiDE" ]; then
    mkdir ./logs/TiDE
fi
seq_len=720
model_name=TiDE
data_name=traffic
config=./configs/longterm_forecast/TiDE_traffic.yaml

for pred_len in 96 192 336 720
do
    echo "training..."
    python3 -u train.py \
      --config $config \
      --seq_len $seq_len \
      --predict_len $pred_len \
      --batch_size 1 \
      --time_feat \
      --save_dir ./logs/TiDE/ \
      --iters 1 >logs/TiDE/$model_name'_'$data_name'_'$seq_len'_'$pred_len.log 2>&1 &
done
