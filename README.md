## 项目结构

```
opencv-demo/
├── src/                    # 源代码文件
│   └── main.cpp           # 主程序
├── build/                 # 构建目录（自动生成）
├── .devcontainer/         # VS Code Dev Container配置（含详细注释）
├── .vscode/               # VS Code配置（含详细注释）
│   ├── c_cpp_properties.json # C++ IntelliSense配置
│   ├── launch.json        # 调试配置
│   ├── settings.json      # 工作区设置
│   └── tasks.json         # 构建任务配置
├── Dockerfile             # Docker镜像配置（含详细注释）
└── CMakeLists.txt         # CMake构建配置
```

## 环境要求

- Docker Desktop (Windows/macOS) 或 Docker Engine (Linux)
- Visual Studio Code
- VS Code扩展：Dev Containers, C/C++, CMake Tools

**注意**：本项目使用Ubuntu 22.04作为基础镜像，Windows用户需要配置Docker国内镜像加速

## 快速开始

### 1. Windows初学者环境配置

#### 1.1 安装Docker Desktop
1. 访问 https://www.docker.com/products/docker-desktop
2. 下载Windows版本的Docker Desktop
3. 运行安装程序，按照提示完成安装
4. 启动Docker Desktop，等待系统托盘图标变为稳定状态

#### 1.2 安装VS Code
1. 访问 https://code.visualstudio.com/
2. 下载Windows版本的Visual Studio Code
3. 运行安装程序，按照提示完成安装

#### 1.3 安装必要扩展
在VS Code中安装以下扩展：
1. **Dev Containers** - 用于容器化开发
2. **C/C++** - C++语言支持
3. **CMake Tools** - CMake构建工具支持

安装方法：
- 打开VS Code
- 按 `Ctrl+Shift+X` 打开扩展面板
- 搜索并安装上述扩展

#### 1.4 配置Docker国内镜像加速（重要！）
由于网络问题，国内用户需要配置Docker镜像加速：

1. 右键系统托盘Docker图标
2. 选择 "Settings" -> "Docker Engine"
3. 在JSON配置中添加：
```json
{
  "registry-mirrors": [
    "https://docker.1ms.run"
  ]
}
```
4. 点击 "Apply & Restart"

### 2. 在容器中开发

#### 2.1 打开项目
1. 打开VS Code
2. 按 `Ctrl+K Ctrl+O` 或 "File" -> "Open Folder"
3. 选择 `opencv-demo` 项目文件夹

#### 2.2 启动容器环境
1. VS Code会自动检测到 `.devcontainer` 配置
2. 屏幕左下角会出现提示 "Reopen in Container"
3. 点击该提示或按 `Ctrl+Shift+P`，输入 "Dev Containers: Reopen in Container"
4. 等待容器构建完成（首次可能需要5-10分钟）

#### 2.3 容器环境说明
容器已预配置以下工具：
- Ubuntu 22.04 LTS
- OpenCV 4.x
- CMake 3.16+
- GCC/G++ 编译器
- GDB 调试器
- Git

### 3. VS Code任务系统说明

项目配置了多个便捷任务，可通过以下方式访问：
- 按 `Ctrl+Shift+P` -> "Tasks: Run Task" -> 选择任务
- 按 `Ctrl+Shift+B` 运行默认构建任务

#### 3.1 主要构建任务
- **"CMake Configure"** - 生成构建系统文件
- **"CMake Build"** - 编译整个项目
- **"CMake Clean"** - 清理构建产物

#### 3.2 运行任务
- **"Run OpenCV Demo"** - 运行主程序
- **"Build and Run"** - 一键构建并运行

#### 3.3 单文件编译任务
- **"C/C++: g++ build active file with OpenCV"** - 编译当前活动文件

> **详细配置说明**：每个配置文件中都包含了详细的中文注释，可以直接查看相应文件了解具体配置。

### 4. 构建项目

在VS Code中打开终端（Terminal -> New Terminal），运行：

```bash
# 配置项目
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug

# 构建项目
cmake --build build --parallel 4

# 或者直接使用VS Code任务
# Ctrl+Shift+P -> Tasks: Run Task -> CMake Build
```

### 5. 运行演示程序

```bash
# 运行程序
./build/bin/opencv_demo

# 或者使用VS Code任务
# Ctrl+Shift+P -> Tasks: Run Task -> Run OpenCV Demo
```

### 6. 调试程序

在VS Code 中有两种调试方式：

#### 6.1 "Debug OpenCV Demo" 配置
**作用**：调试完整的CMake项目构建的程序

#### 6.2 "Debug Single File" 配置
**作用**：调试当前活动的单个C++文件

> **详细调试配置说明**：具体配置详情请查看 `.vscode/launch.json` 文件中的详细注释。
