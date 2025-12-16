cmake_minimum_required(VERSION 3.16)
project(OpenCVDemo VERSION 1.0.0 LANGUAGES CXX)

# 设置C++标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# 设置构建类型
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# 设置编译选项
set(CMAKE_CXX_FLAGS "-Wall -Wextra -Wpedantic")
set(CMAKE_CXX_FLAGS_DEBUG "-g -O0 -DDEBUG")
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG")

# 查找OpenCV包
find_package(OpenCV REQUIRED)

# 包含OpenCV头文件
include_directories(${OpenCV_INCLUDE_DIRS})

# 包含项目头文件
include_directories(${CMAKE_SOURCE_DIR}/include)

# 添加可执行文件
add_executable(opencv_demo
    src/main.cpp
)

# 链接OpenCV库
target_link_libraries(opencv_demo ${OpenCV_LIBS})

# 设置输出目录
set_target_properties(opencv_demo PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)

# 安装规则
install(TARGETS opencv_demo
    RUNTIME DESTINATION bin
)

# 安装头文件（只有当目录存在时）
if(EXISTS "${CMAKE_SOURCE_DIR}/include")
    install(DIRECTORY include/
        DESTINATION include/opencv_demo
        FILES_MATCHING PATTERN "*.hpp"
    )
endif()

# 安装示例图片（只有当目录存在时）
if(EXISTS "${CMAKE_SOURCE_DIR}/assets")
    install(DIRECTORY assets/
        DESTINATION share/opencv_demo/assets
        FILES_MATCHING PATTERN "*.jpg" PATTERN "*.png" PATTERN "*.jpeg"
    )
endif()

# 打印配置信息
message(STATUS "OpenCV version: ${OpenCV_VERSION}")
message(STATUS "OpenCV libraries: ${OpenCV_LIBS}")
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "C++ standard: ${CMAKE_CXX_STANDARD}")