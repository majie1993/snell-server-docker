# Snell Server Docker

基于 Docker 的 Snell Server 部署方案。

**Docker Hub**: `waterwood/snell-server`

## 快速开始

### 1. 创建配置文件

```bash
mkdir -p ./snell-config
cat > ./snell-config/snell-server.conf << EOF
[snell-server]
listen = 0.0.0.0:6160
psk = your-pre-shared-key-here
EOF
```

### 2. Docker Compose

```yaml
services:
  snell-server:
    image: waterwood/snell-server:latest
    container_name: snell-server
    ports:
      - "6160:6160"
    volumes:
      - ./snell-config:/etc/snell
    restart: unless-stopped
```

```bash
docker-compose up -d
```