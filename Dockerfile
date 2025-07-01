# 多阶段构建 - 下载并解压
FROM alpine:latest AS downloader
ARG SNELL_VERSION=v5.0.0b1
RUN apk add --no-cache wget unzip
WORKDIR /tmp
RUN wget https://dl.nssurge.com/snell/snell-server-${SNELL_VERSION}-linux-amd64.zip \
    && unzip snell-server-${SNELL_VERSION}-linux-amd64.zip

# 运行镜像 - 使用 Debian 支持 glibc
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates tzdata && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/local/bin
COPY --from=downloader /tmp/snell-server .
RUN chmod +x snell-server

# 创建配置目录
WORKDIR /etc/snell
VOLUME ["/etc/snell"]

# 暴露默认端口
EXPOSE 6160

ENTRYPOINT ["snell-server"]
CMD ["-c", "/etc/snell/snell-server.conf"]