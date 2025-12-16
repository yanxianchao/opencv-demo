# ================================================
# OpenCV C++ 开发环境 Docker 镜像配置
# ================================================

# 基础镜像：Ubuntu 22.04 LTS
# 作用：提供稳定、长期支持的操作系统环境
FROM ubuntu:22.04

# ================================================
# 环境变量配置
# ================================================

# 设置非交互式前端，防止apt安装时的交互式提问
# 作用：确保自动化构建过程中不会因用户输入而中断
ENV DEBIAN_FRONTEND=noninteractive

# 设置时区为上海
# 作用：确保容器内的时间和日志时间戳正确显示
ENV TZ=Asia/Shanghai

# ================================================
# 国内镜像源配置（网络优化）
# ================================================

# 使用阿里云镜像源替换默认源，加速国内下载
# 作用：显著提升apt包下载速度，避免网络超时问题
RUN sed -i 's|http://archive.ubuntu.com|http://mirrors.aliyun.com|g' /etc/apt/sources.list && \
    sed -i 's|http://security.ubuntu.com|http://mirrors.aliyun.com|g' /etc/apt/sources.list

# ================================================
# 系统工具和开发环境安装
# ================================================

# 安装基本开发工具
# build-essential: 包含GCC、G++编译器和make等构建工具
# cmake: 跨平台构建系统，用于管理项目构建过程
# git: 版本控制系统，用于代码管理
# wget: 命令行下载工具，用于获取网络资源
# pkg-config: 库配置查询工具，帮助编译器找到依赖库
# ca-certificates: SSL证书，确保安全连接
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    wget \
    pkg-config \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 安装OpenCV开发库
# libopencv-dev: OpenCV核心开发库，包含图像处理功能
# libopencv-contrib-dev: OpenCV贡献模块，提供更多算法实现
RUN apt-get update && apt-get install -y \
    libopencv-dev \
    libopencv-contrib-dev \
    && rm -rf /var/lib/apt/lists/*

# 安装开发辅助工具
# gdb: GNU调试器，用于程序调试和问题排查
# valgrind: 内存检测工具，帮助发现内存泄漏和错误
# clang-format: 代码格式化工具，保持代码风格一致
# clang-tidy: 静态代码分析工具，提高代码质量和安全性
RUN apt-get update && apt-get install -y \
    gdb \
    valgrind \
    clang-format \
    clang-tidy \
    && rm -rf /var/lib/apt/lists/*

# ================================================
# 工作环境配置
# ================================================

# 设置工作目录
# 作用：为后续操作提供明确的工作路径
WORKDIR /workspace

# ================================================
# 用户权限配置（安全最佳实践）
# ================================================

# 创建非root用户，提高容器安全性
# 动态检测UID 1000是否已被占用，避免权限冲突
# 如果被占用则使用UID 1001
# 创建developer用户组和用户，设置密码和sudo权限
RUN if id -u 1000 >/dev/null 2>&1; then \
        echo "UID 1000 already exists, using UID 1001"; \
        USER_ID=1001; \
    else \
        USER_ID=1000; \
    fi && \
    groupadd -g $USER_ID developer && \
    useradd -u $USER_ID -g developer -m -s /bin/bash developer && \
    echo "developer:developer" | chpasswd && \
    usermod -aG sudo developer

# 配置sudo权限，允许developer用户无密码使用sudo
# 作用：提供开发便利性，避免频繁输入密码
RUN echo "developer ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# 切换到developer用户运行后续命令
# 作用：遵循安全最佳实践，避免以root身份运行应用
USER developer

# 设置默认shell为bash
# 作用：确保脚本兼容性和功能完整性
SHELL ["/bin/bash", "-c"]
