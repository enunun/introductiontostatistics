FROM rust:latest

# 必要なパッケージをインストールし、typst-cliをcargo installでインストール
RUN apt-get update \
	&& apt-get install -y --no-install-recommends git build-essential ca-certificates \
	&& cargo install --locked typst-cli \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/*