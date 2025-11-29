FROM rust:latest

# 必要なパッケージをインストールし、typst-cliをcargo installでインストール
RUN apt-get update \
    && apt-get install -y --no-install-recommends git build-essential ca-certificates wget unzip \
    && cargo install --locked typst-cli \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Libertinus フォントのインストール
RUN mkdir -p /usr/share/fonts/opentype/libertinus \
    && wget -qO /tmp/Libertinus-7.051.zip https://github.com/alerque/libertinus/releases/download/v7.051/Libertinus-7.051.zip \
    && unzip -q /tmp/Libertinus-7.051.zip -d /usr/share/fonts/opentype/libertinus \
    && rm -rf /tmp/Libertinus-7.051.zip \
    && fc-cache -fv

# Noto Sans Japanese フォントのインストール
RUN apt-get update \
    && apt-get install -y --no-install-recommends fonts-noto-cjk \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && fc-cache -fv

# TeX Gyre Pagella フォントのインストール
RUN apt-get update \
    && apt-get install -y --no-install-recommends fonts-texgyre fonts-texgyre-math \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
