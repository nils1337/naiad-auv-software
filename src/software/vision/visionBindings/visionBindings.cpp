#include "visionBindings.hpp"
#include "opencv2/highgui/highgui.hpp"
#include "opencv2/imgproc/imgproc.hpp"
#include "opencv2/opencv.hpp"
#include <vector>

std::vector<cv::Mat> img;
cv::VideoCapture cap;

void Core_Wrap::push_back(char * src)
{
  img.push_back(cv::imread(src));
}

void Core_Wrap::imread(char * name)
{
  cv::imread(name);
}

int Core_Wrap::imwrite(char * name, int src)
{
  if (cv::imwrite(name, img.at(src)))
    return 1;
  else
    return 0;
}

void Core_Wrap::imshow(char * name, int src)
{
  cv::imshow(name, img.at(src));
}

void Core_Wrap::waitKey(int time)
{
  cv::waitKey(time);
}

int Core_Wrap::size(void)
{
   return img.size();
}

Core_Wrap::Core_Wrap(){}


void Processing_Wrap::cvtColor(int src, int dst, int filter)
{
  cv::cvtColor(img.at(src), img.at(dst), filter);
}

void Processing_Wrap::Canny(int src, int dst, int lThresh, int hThresh, int kernelSize)
{
  cv::Canny(img.at(src), img.at(dst), lThresh, hThresh, kernelSize);
}

Processing_Wrap::Processing_Wrap(){}

// VideoCapture test - Stream

void Preprocessing_Wrap::VideoCaptureOpen(void)
{
  cap.open(0);
}

void Preprocessing_Wrap::namedWindow(char * name, int num)
{
  cv::namedWindow(name, num);
}

void Preprocessing_Wrap::nextFrame(int dst)
{
  cap >> img.at(dst);
}

Preprocessing_Wrap::Preprocessing_Wrap(){}
