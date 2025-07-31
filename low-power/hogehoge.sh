#!/bin/bash
echo "--- Starting LOW POWER mode (YOLOv11n) ---"

# 無限ループで推論を実行
while true; do
  echo "[LOW] Running inference with YOLOv11n..."
  # yoloコマンドで推論を実行。モデルは初回実行時に自動でダウンロードされます。
  # save=True で結果画像が runs/detect/predict/ に保存されます。
  yolo predict model=yolo11n.pt source='https://ultralytics.com/images/bus.jpg' save=True

  # 負荷を抑えるため長めに待機
  sleep 30
done
