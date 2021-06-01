#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

#include <iostream>

using namespace cv;
using namespace std;

int main(int argc, char** argv)
{
    // Read the file
    char* imageName = argv[1];

    Mat image = imread(imageName, IMREAD_COLOR);

    if(image.empty())
    {
        cerr << " No image data " << endl;
        return EXIT_FAILURE;
    }

    Mat gray_image;

    cvtColor(image, gray_image, CV_BGR2GRAY);

    imwrite("../data/images/Gray_image.jpg", gray_image);

    namedWindow(imageName, CV_WINDOW_AUTOSIZE);
    namedWindow("Gray image", CV_WINDOW_AUTOSIZE);

    imshow(imageName, image);
    imshow("Gray image", gray_image);

    // Wait for a keystroke in the window
    waitKey(0);

    return EXIT_SUCCESS;
}
