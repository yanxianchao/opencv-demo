#include <iostream>
#include <opencv2/opencv.hpp>

/**
 * @brief 测试OpenCV环境配置
 */
int main() {
    std::cout << "=== OpenCV 环境测试 ===" << std::endl;

    // 打印OpenCV版本
    std::cout << "OpenCV Version: " << CV_VERSION << std::endl;

    // 创建一个简单的图像
    cv::Mat test_image = cv::Mat::zeros(200, 300, CV_8UC3);

    // 在图像上绘制一些内容
    cv::putText(test_image, "OpenCV Test", cv::Point(50, 100), cv::FONT_HERSHEY_SIMPLEX, 1,
                cv::Scalar(0, 255, 0), 2);

    // 显示图像信息
    std::cout << "创建图像尺寸: " << test_image.cols << "x" << test_image.rows << std::endl;
    std::cout << "图像通道数: " << test_image.channels() << std::endl;

    // 测试基本操作
    cv::Mat gray_image;
    cv::cvtColor(test_image, gray_image, cv::COLOR_BGR2GRAY);
    std::cout << "灰度图像转换成功" << std::endl;

    std::cout << "✅ OpenCV环境配置正确!" << std::endl;

    return 0;
}
