#!/usr/bin/env bash

echo "--- Power Manager started in continuous loop mode ---"
echo "This script will now run forever. To stop it, use 'kill <PID>'."

while true; do
    # --- ステップ1: 電源状態に基づいて必要なサービスを決定 ---
    
    # 偽の電源情報スクリプトを使って現在の状態を取得
    REQUIRED_STATUS=$(./fake_power_source.sh)
    
    TARGET_SERVICE=""
    if [[ "$REQUIRED_STATUS" == "AC" ]]; then
        TARGET_SERVICE="app-ac"
    else
        TARGET_SERVICE="app-battery"
    fi

    # --- ステップ2: 現在実行中のサービス名を取得 ---

    CURRENT_SERVICE=""
    # コンテナ名で実行中か確認
    if docker ps -q --filter "name=my-app-container" | grep -q .; then
        # 実行中であれば、docker-composeのラベルからサービス名を取得
        CURRENT_SERVICE=$(docker inspect my-app-container --format '{{ index .Config.Labels "com.docker.compose.service" }}' 2>/dev/null || echo "unknown")
    fi

    # --- ステップ3: 状態を比較し、必要であればコンテナを切り替え ---

    # 必要なサービスと実行中のサービスが異なる場合のみ、処理を実行
    if [[ "$CURRENT_SERVICE" != "$TARGET_SERVICE" ]]; then
        echo # ログを見やすくするための改行
        echo "----------------------------------------"
        echo "STATUS CHANGE DETECTED at $(date)"
        echo "  Required service: $TARGET_SERVICE (based on status: $REQUIRED_STATUS)"
        echo "  Currently running: $CURRENT_SERVICE"
        echo "  Action: Switching container..."
        echo "----------------------------------------"

        # 古いサービスを停止し、コンテナを削除
        docker-compose down --remove-orphans

        # 新しいターゲットサービスをバックグラウンドで起動
        docker-compose up -d "$TARGET_SERVICE"

        echo "=> Successfully switched to $TARGET_SERVICE."
        echo
    fi

    # 次のチェックまで待機
    sleep 10
done
