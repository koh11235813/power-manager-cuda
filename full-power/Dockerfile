# ベースイメージはJetsonのJetPack環境そのもの。PyTorchもTensorRTも入っている。
FROM nvcr.io/nvidia/l4t-jetpack:r36.3.0
# JetPack 6.0 GA (SDK 6.2) の場合、r36.3.0 が正式対応です。r36.4.0はDeveloper Preview版です。

# 環境設定
ENV DEBIAN_FRONTEND=noninteractive

# 必要な基本ツールと、画像・動画処理ライブラリの依存関係をインストール
# ベースイメージに多くは含まれていますが、念のため明示します。
RUN apt-get update && apt-get install -y \
    python3-pip \
    git \
    libgl1-mesa-glx \
    ffmpeg libsm6 libxext6 \
    libjpeg-dev libpng-dev

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/arm64/cuda-keyring_1.1-1_all.deb \
    && dpkg -i cuda-keyring_1.1-1_all.deb \
    && apt-get update \
    && apt-get -y install libcusparselt0 libcusparselt-dev libopenblas-dev

RUN apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install numpy==1.26.4

# RUN wget https://developer.download.nvidia.com/compute/redist/jp/v60dp/pytorch/torch-2.3.0a0+ebedce2.nv24.02-cp310-cp310-linux_aarch64.whl \
#     && pip3 install torch-2.3.0a0+ebedce2.nv24.02-cp310-cp310-linux_aarch64.whl \
#     && rm torch-2.3.0a0+ebedce2.nv24.02-cp310-cp310-linux_aarch64.whl

RUN wget https://kinoko1943.jp/files/torch-2.3.0a0+ebedce2.nv24.02-cp310-cp310-linux_aarch64.whl \
    && pip3 install torch-2.3.0a0+ebedce2.nv24.02-cp310-cp310-linux_aarch64.whl \
    && rm torch-2.3.0a0+ebedce2.nv24.02-cp310-cp310-linux_aarch64.whl

RUN wget https://kinoko1943.jp/files/torchvision-0.18.0a0+6043bc2-cp310-cp310-linux_aarch64.whl \
    && pip3 install https://kinoko1943.jp/files/torchvision-0.18.0a0+6043bc2-cp310-cp310-linux_aarch64.whl \
    && rm torchvision-0.18.0a0+6043bc2-cp310-cp310-linux_aarch64.whl

RUN python3 -m pip install \
    pandas \
    matplotlib \
    seaborn \
    ultralytics

# pipをアップグレードし、必要なPythonパッケージをインストール
# ベースイメージに含まれるPyTorchをそのまま利用します。
# RUN python3 -m pip install --upgrade pip
# RUN pip3 install \
#     pandas \
#     matplotlib \
#     seaborn \
#     ultralytics

# 実行スクリプトをコンテナにコピー
# (ビルドコンテキストに応じてパスを修正してください)
COPY full-power/hogehoge.sh /hogehoge.sh 
# COPY low-power/hogehoge.sh /hogehoge.sh # low-power用

RUN chmod +x /hogehoge.sh

# コンテナ起動時にスクリプトを実行
CMD ["/hogehoge.sh"]
