# ベースイメージをJetson用のものに変更
FROM nvcr.io/nvidia/l4t-base:r36.2.0

# 対話形式のプロンプトを無効化
ENV DEBIAN_FRONTEND=noninteractive

# 必要なツールと、OpenCVの依存関係ライブラリをインストール
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    git \
    libgl1-mesa-glx \
    # 不要なキャッシュを削除
    && rm -rf /var/lib/apt/lists/*

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/arm64/cuda-keyring_1.1-1_all.deb \
    && dpkg -i cuda-keyring_1.1-1_all.deb \
    && apt-get update \
    && apt-get -y install libcusparselt0 libcusparselt-dev

RUN wget https://developer.download.nvidia.com/compute/redist/jp/v61/pytorch/torch-2.5.0a0+872d972e41.nv24.08.17622132-cp310-cp310-linux_aarch64.whl \
    && pip3 install torch-2.5.0a0+872d972e41.nv24.08.17622132-cp310-cp310-linux_aarch64.whl \
    && rm torch-2.5.0a0+872d972e41.nv24.08.17622132-cp310-cp310-linux_aarch64.whl


# Ultralyticsライブラリをインストール
# これでCUDA対応のPyTorchが自動で入ります
RUN pip3 install ultralytics

# 実行スクリプトをコンテナにコピー
# (ビルドコンテキストに応じてパスを修正してください)
COPY full-power/hogehoge.sh /hogehoge.sh 
# COPY low-power/hogehoge.sh /hogehoge.sh # low-power用

RUN chmod +x /hogehoge.sh

# コンテナ起動時にスクリプトを実行
CMD ["/hogehoge.sh"]
