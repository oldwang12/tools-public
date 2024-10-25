#!/bin/bash

# 设置变量
REPO="oldwang12/tools-public"  # 替换为目标 GitHub 仓库
OS=$(uname -s | tr '[:upper:]' '[:lower:]')  # 获取操作系统名称

# 根据操作系统设置下载链接
case $OS in
    linux)
        OS="linux"
        ;;
    darwin)
        OS="darwin"
        ;;
    mingw*|msys*)
        OS="windows"
        ;;
    *)
        echo "不支持的操作系统: $OS"
        exit 1
        ;;
esac

# 构建下载 URL
DOWNLOAD_URL="https://raw.githubusercontent.com/$REPO/refs/heads/master/fast-docker-hub/fast-docker-hub-$OS"

# Windows 文件扩展名
if [ "$OS" == "windows" ]; then
    DOWNLOAD_URL="$DOWNLOAD_URL.exe"
fi

# 下载二进制文件
echo "正在下载 $DOWNLOAD_URL ..."
curl -LO "$DOWNLOAD_URL"

# 检查下载是否成功
if [ $? -ne 0 ]; then
    echo "下载失败"
    exit 1
fi

# 给文件添加执行权限（仅适用于 Linux 和 macOS）
if [ "$OS" != "windows" ]; then
    chmod +x "fast-docker-hub-$OS"
fi

# 执行下载的二进制文件
echo -e "\033[32m下载完成，你可以通过下面方式加速镜像：\033[0m"
if [ "$OS" == "windows" ]; then
    echo -e "\033[32m./fast-docker-hub-$OS.exe nginx\033[0m"
else
    echo -e "\033[32m./fast-docker-hub-$OS nginx\033[0m"
fi