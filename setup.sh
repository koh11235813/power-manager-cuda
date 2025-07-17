#!/bin/bash
# マルチアーキテクチャ対応のビルダーを作成（初回のみ）
docker buildx create --name mybuilder --use
docker buildx inspect --bootstrap

# full-power イメージをビルドしてプッシュ
docker buildx build --platform linux/amd64,linux/arm64 -t your-username/my-app:full-power -f full-power/Dockerfile . --push

# low-power イメージをビルドしてプッシュ
docker buildx build --platform linux/amd64,linux/arm64 -t your-username/my-app:low-power -f low-power/Dockerfile . --push
