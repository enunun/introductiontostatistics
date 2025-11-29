FROM rust:latest

# 必要なパッケージをインストールし、typst-cliをcargo installでインストール
RUN apt-get update \
    && apt-get install -y --no-install-recommends git build-essential ca-certificates wget unzip \
    && cargo install --locked typst-cli \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# XITS Math フォントのインストール
RUN mkdir -p /usr/share/fonts/opentype/xits \
    && wget -qO /tmp/XITS-1.302.zip https://github.com/aliftype/xits/releases/download/v1.302/XITS-1.302.zip \
    && unzip -q /tmp/XITS-1.302.zip -d /usr/share/fonts/opentype/xits \
    && rm -rf /tmp/XITS-1.302.zip \
    && fc-cache -fv

# Noto Sans Japanese フォントのインストール
RUN apt-get update \
    && apt-get install -y --no-install-recommends fonts-noto-cjk \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && fc-cache -fv

# TeX Gyre Pagella フォントのインストール
RUN apt-get update \
    && apt-get install -y --no-install-recommends fonts-texgyre \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Fira Sans/Mono フォントのインストール
RUN mkdir -p /usr/share/fonts/opentype/fira \
    && wget -qO /tmp/Fira-master.zip https://github.com/mozilla/Fira/archive/refs/tags/4.202.zip \
    && unzip -q /tmp/Fira-master.zip -d /tmp/Fira-master \
    && cp /tmp/Fira-master/Fira-4.202/otf/FiraSans* /usr/share/fonts/opentype/fira/ \
    && cp /tmp/Fira-master/Fira-4.202/otf/FiraMono* /usr/share/fonts/opentype/fira/ \
    && rm -rf /tmp/Fira-master.zip /tmp/Fira-master \
    && fc-cache -fv