#include <stdlib.h>
#include <stdio.h>
#include <string>

class Core_Wrap{

virtual void push_back(char * src);

virtual void imread(char * name);

virtual int imwrite(char * name, int src);

virtual void imshow(char * name, int src);

virtual void waitKey(int time);

virtual int size(void);

Core_Wrap();

};


class Processing_Wrap{
virtual void cvtColor(int src, int dst, int filter);

virtual void Canny(int src, int dst, int lThresh, int hThresh, int kernelSize);

Processing_Wrap();
};


// VideoCapture test - Stream

class Preprocessing_Wrap{
virtual void VideoCaptureOpen(void);

virtual void namedWindow(char * name, int num);

virtual void nextFrame(int dst);

Preprocessing_Wrap();
};

/* mission wrap
class Mission_Handler_Wrap{
virtual void VideoCaptureOpen(void);

virtual void namedWindow(char * name, int num);

virtual void nextFrame(int dst);

Highgui_Wrap();
};*/