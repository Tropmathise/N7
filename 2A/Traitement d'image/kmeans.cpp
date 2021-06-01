#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/imgcodecs.hpp>
#include <iostream>

using namespace cv;
using namespace std;

void printHelp(const string& progName)
{
    cout << "Usage:\n\t " << progName << " <image_file> <K_num_of_clusters> [<image_ground_truth>]" << endl;
}

vector<int> mykmeans(Mat image, int k, int max_iter, vector<int> labels, Mat centers) {

    // Conversion to grayscale
    Mat gray_image = image.clone();
    cvtColor(image, gray_image, CV_BGR2GRAY);
		gray_image = gray_image.reshape(1, image.rows*image.cols);

    // Partition of the picture given the grayscale of the pixels
    int step = (int) 255/k;
    vector<int> sum(k,0);    // To prepare centers' estimation
    vector<int> count(k,0);  // To prepare centers' estimation
    for (int i=0; i<gray_image.rows; i++) {
        for (int c=0; c<k; c++) {
            int color = (int) gray_image.at<uchar>(i,0);
            if (color < (c+1)*step) {
                labels.push_back(c);
                sum[c] += color;
                count[c] ++;
                break;
            }
        }
    }

    // Estimate centers
    for (int i=0; i<k; i++) {
        centers.at<float>(i,0) = float(sum[i])/float(count[i]);
    }

    // Iterations
    bool modified = true;
	int nb_iters;
    while (modified) {
	nb_iters ++;
        modified = false;
        for (int i=0; i<gray_image.rows; i++) {
            int min = 255;
            int argmin;
            for (int c=0; c<centers.rows; c++) {
                int diff = abs(gray_image.at<uchar>(i,0) - centers.at<float>(c,0));
                if (diff <= min) {
                    min = diff;
                    argmin = c;
                }
            }
            if (argmin != labels[i]) {
                modified = true;
                sum[labels[i]] -= gray_image.at<uchar>(i,0);
                count[labels[i]] --;
                labels[i] = argmin;
                sum[argmin] += gray_image.at<uchar>(i,0);
                count[argmin] ++;
            }
        }

        for (int i=0; i<k; i++) {
            centers.at<float>(i,0) = sum[i]/count[i];
        }

				if (nb_iters == max_iter) {
					modified = false;
				}
    }
		return labels;
}

// Function which evaluates the quality of our segmentation (we  consider positives to be white pixels and negatives to be be black ones)
// Params :
//      In :    Mat result -> the result of our segmentation ie a black and white image
//              Mat ref -> the reference segmentation given in the subject, considered as 100% correct
//      Out :   Vector<int> containing the different indicators, its shape is [TP,FN,FP]
vector<int> evaluate(Mat result, Mat ref) {

    vector<int> counts(3);

    for (int i = 0; i<result.rows; i++) {
        for (int j = 0;j<result.cols;j++) {
            if (result.at<uchar>(i,j) >= 127 && ref.at<uchar>(i,j) >= 127) {
                counts[0] ++;
            } else if (result.at<uchar>(i,j) < 127 && ref.at<uchar>(i,j) >= 127) {
                counts[1] ++;
            } else if (result.at<uchar>(i,j) >= 127 && ref.at<uchar>(i,j) < 127) {
                counts[2] ++;
            }
        }
    }
    return counts;
}

int main(int argc, char** argv)
{
    if (argc != 3 && argc !=4)
    {
        cout << " Incorrect number of arguments." << endl;
        printHelp(string(argv[0]));
        return EXIT_FAILURE;
    }
    
    const auto imageFilename = string(argv[1]);
    const string groundTruthFilename = (argc ==4) ? string(argv[3]) : string();
    const int k = stoi(argv[2]);
    
    // Loading the input images

    Mat image;
    image = imread(imageFilename, CV_LOAD_IMAGE_COLOR);
    cout << image.size() << endl;
    if(image.empty())
    {
        cout << "Could not open or find the image" << std::endl;
        return EXIT_FAILURE;
    }
    
    Mat image_ref;
    image_ref = imread(groundTruthFilename, CV_LOAD_IMAGE_COLOR);

    if(image_ref.empty())
    {
        cout << "Could not open or find the image" << std::endl;
        return EXIT_FAILURE;
    }
    
    // Creating the work variable by modifying the image we loaded

    Mat image_vect = image.reshape(1, image.rows*image.cols);
    image_vect.convertTo(image_vect,CV_32F);

    // Declaring useful variables

    vector<int> labels_ocv;
    int attempts = 10;
    int flags;
    Mat_<float> centers_ocv;

		vector<int> labels_perso;
		Mat centers_perso(k,1,CV_32F, Scalar(0));

    // Calling kmean

    cout << "Entering Kmeans" << std::endl;

    cv::kmeans(image_vect, k, labels_ocv, TermCriteria(TermCriteria::EPS+TermCriteria::COUNT, 10, 1.0), attempts, flags, centers_ocv);
    vector<int> labels_perso_computed = mykmeans(image, k, 100, labels_perso, centers_perso);

    cout << "Kmeans done" << std::endl;
    // Computing the result through centers ad labels, given by kmeans

    //for (int i = 0; i<image.rows*image.cols; i++){
    //    image_vect.at<uchar>(i,0) = (uchar) centers(labels[i],0);
    //    image_vect.at<uchar>(i,1) = (uchar) centers(labels[i],1);
    //    image_vect.at<uchar>(i,2) = (uchar) centers(labels[i],2);
    //}

    Mat result_perso(image.rows*image.cols,1,CV_8UC1,Scalar(0));
    for (int i = 0; i<image.rows*image.cols; i++){
				if (labels_perso_computed[i] == 0) {
        	result_perso.at<uchar>(i,0) = 255;
				} else if (labels_perso_computed[i] == 1) {
					result_perso.at<uchar>(i,0) = 0;
				}
    }
    result_perso = result_perso.reshape(1, image.rows);
    result_perso.convertTo(result_perso,CV_8UC1);
		cout << result_perso.size() << endl;
    //Mat result = image_vect.reshape(3, image.rows);
    //result.convertTo(result,CV_8UC3);
    //cvtColor(result, result, CV_BGR2GRAY);

    //cout << typeid(image_ref).name() << endl;
    Mat result_ocv(image.rows*image.cols,1,CV_8UC1,Scalar(0));
		cout << labels_ocv.size() << endl;
		cout << result_ocv.size() << endl;
    for (int i=0; i<image.rows*image.cols; i++) {
        result_ocv.at<uchar>(i,0) = 255*(1-labels_ocv[i]);
    }
		result_ocv = result_ocv.reshape(1, image.rows);
    result_ocv.convertTo(result_ocv,CV_8UC1);
    //imageFilename.erase(imageFilename.end()-4, 4);
    //String path = path + "_kmeans.jpg";
    //imwrite(path, result);
    imwrite("../results/ocv_kmeans8.png", result_ocv);

    //imageFilename.erase(imageFilename.end()-4, 4);
    //String path = path + "_kmeans.jpg";
    //imwrite(path, result);
    imwrite("../results/mykmeans8.png", result_perso);


    // Display

        //Indicators
    vector<int> counts_ocv = evaluate(result_ocv, image_ref);
		cout << counts_ocv[0] <<endl;
		cout << counts_ocv[1] <<endl;
		cout << counts_ocv[2] <<endl;
    float p_ocv = float(counts_ocv[0])/(counts_ocv[0]+counts_ocv[2]);
    float s_ocv = float(counts_ocv[0])/(counts_ocv[0]+counts_ocv[1]);
    float dsc_ocv = 2*float(counts_ocv[0])/(2*counts_ocv[0]+counts_ocv[2]+counts_ocv[1]);

    cout << "Accuracy for open cv: " << p_ocv << std::endl;
    cout << "Sensibility for open cv: " << s_ocv << std::endl;
    cout << "Similarity for open cv: " << dsc_ocv << std::endl;

		vector<int> counts_perso = evaluate(result_perso, image_ref);
		cout << counts_perso[0] <<endl;
		cout << counts_perso[1] <<endl;
		cout << counts_perso[2] <<endl;
    float p_perso = float(counts_perso[0])/(counts_perso[0]+counts_perso[2]);
    float s_perso = float(counts_perso[0])/(counts_perso[0]+counts_perso[1]);
    float dsc_perso = 2*float(counts_perso[0])/(2*counts_perso[0]+counts_perso[2]+counts_perso[1]);

    cout << "Accuracy for my kmeans: " << p_perso << std::endl;
    cout << "Sensibility for my kmeans: " << s_perso << std::endl;
    cout << "Similarity for my kmeans: " << dsc_perso << std::endl;

        //Images
    namedWindow("Start", CV_WINDOW_AUTOSIZE);
    imshow("Start", image);
    namedWindow("Reference", CV_WINDOW_AUTOSIZE);
    imshow("Reference", image_ref);
    namedWindow("Result_OCV", CV_WINDOW_AUTOSIZE);
    imshow("Result_OCV", result_ocv);
		namedWindow("Result_Perso", CV_WINDOW_AUTOSIZE);
    imshow("Result_Perso", result_perso);

    waitKey(0);

    return EXIT_SUCCESS;
}
