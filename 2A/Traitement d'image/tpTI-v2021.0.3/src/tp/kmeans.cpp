#include <opencv2/core.hpp>
#include <opencv2/imgcodecs.hpp>
#include <opencv2/highgui.hpp>
#include <opencv2/imgproc.hpp>
#include <opencv2/imgcodecs.hpp>
#include <iostream>
#include <string>
#include <map>

using namespace cv;
using namespace std;


void printHelp(const string& progName)
{
    cout << "Usage:\n\t " << progName << " <image_file> <K_num_of_clusters> [<image_ground_truth>]" << endl;
}

//choix du centre le plus proche 
uchar getNearestCluster(uchar valeur, const vector<int>& data){
    uchar voisinpp = data[0];
    uchar diff=valeur-voisinpp;
    for (uchar i : data){
        if (abs(valeur-i)<diff){
            diff=abs(valeur-i);
            voisinpp = i;
        }
    } return voisinpp;
}

int vectMoy(const vector<uchar> data) {
    int somme =0;
    for (int i : data){
        somme=somme+i;
    }
    int res = somme/data.size();
    return res;
}

Mat my_kmeans(Mat image, int k, long iters_max)
{
    Mat gray_image;
    cvtColor(image, gray_image, CV_RGB2GRAY);
    gray_image=gray_image.reshape(1,gray_image.total());

    vector<int> labels;
    // map avec la liste de chaque pixels correspondant au label
    map<uchar, vector<uchar>> classes;
    int pos=(int) 255./(k+1);

    // moyenne en niveau de gris pour choisir les clusterrs initiaux
    for (int i=pos;i<255;i+=pos){
        labels.push_back(i);
    }

    long nb_iters=0; 
    double EPS = 0.0001;
    double classe_changee=EPS+1;

    while(classe_changee<EPS || nb_iters < iters_max){
        for(unsigned int i=0;i<gray_image.total();i++){
            int value=(int) gray_image.at<uchar>(0,i);
            uchar voisinpp=getNearestCluster(value, labels);
            classes[voisinpp].push_back(value);
            gray_image.at<uchar>(0,i)=voisinpp;
        }
        classe_changee=0;
        for(int i=0; i<k; i++){
            int classe_new=vectMoy(classes[labels[i]]);
            classe_changee=abs(labels[i]-classe_new);
            labels[i]=classe_new;
        }
        classe_changee/=k;
        nb_iters++;
    }
    
    gray_image=gray_image.reshape(1,image.rows);
    return gray_image;
}

// Calculer les TP FP FN TN des images
void segmentationQuality(Mat image_ref, Mat my_image_seg, Mat image_seg){

    assert (image_ref.total()==image_seg.total() && image_seg.total()==my_image_seg.total());

    int taille = my_image_seg.total();
    int nb_lig=my_image_seg.rows;
    int nb_col=my_image_seg.cols;

    //conversion en noir et blanc des images
    // le seuil est à changer pour chaque image (pas très optimal)
    int seuil = 120;
    //conversion en noir et blanc de l'image segmentée avec my_kmeans
    Mat my_image_nb=my_image_seg<seuil;
    // conversion en noir et blanc de l'image segmentée avec openCV
    Mat image_seg_nb;
    cvtColor(image_seg,image_seg_nb, CV_RGB2GRAY);
    image_seg_nb=image_seg_nb<seuil;

    // Affichage des images en noir et blanc
    imshow("Image segmentée opencv nb", image_seg_nb);
    imshow("Image segmentée my_kmeans nb", my_image_nb);
    imshow("Image ref nb", image_ref);

    imwrite("../data/images/Image8k2_segmentee_nb.jpg", image_seg_nb);
    imwrite("../data/images/My_Image8k2_segmentee_nb.jpg", my_image_nb);
    
    // initialisation des TP FP FN TN
    // respectivement cv et my pour open cv et my_kmeans
    long TP_cv=0;
    long TN_cv=0;
    long FN_cv=0;
    long FP_cv=0;
    long TP_my=0;
    long TN_my=0;
    long FN_my=0;
    long FP_my=0;
    long pixels_non_attribues_cv=0;
    long pixels_non_attribues_my=0;
    

    // parcours des pixels des images 
    for (int i=0; i<nb_lig; i++){
        for(int j=0; j<nb_col;j++){
            if((int) image_ref.at<uchar>(i,j)==255){
                if((int) image_seg_nb.at<uchar>(i,j)==255){
                    TP_cv++;
                } else if ((int) image_seg_nb.at<uchar>(i,j)==0) {
                    FP_cv++;
                }
                if((int) my_image_nb.at<uchar>(i,j)==255){
                    TP_my++;
                } else if ((int) my_image_nb.at<uchar>(i,j)==0) {
                    FP_my++;
                } 
            } else if ((int) image_ref.at<uchar>(i,j)==0) {
                if((int) image_seg_nb.at<uchar>(i,j)==0){
                    TN_cv++;
                } else if ((int) image_seg_nb.at<uchar>(i,j)==255) {
                    FN_cv++;
                }
                if((int) my_image_nb.at<uchar>(i,j)==255){
                    TN_my++;
                } else if ((int) my_image_nb.at<uchar>(i,j)==0){
                    FN_my++;
                } 
            } 
        }
    }
    // on verifie que tous les pixels ont bien été attribué
    long somme_my = FN_my+FP_my+TN_my+TP_my;
    long somme_cv = FN_cv+FP_cv+TN_cv+TP_cv;  
    assert(somme_my==taille); 
    assert(somme_cv==taille);
 
    // Calcul de la précision
    double precision_cv = (double) TP_cv/(TP_cv+FP_cv);
    double precision_my = (double) TP_my/(TP_my+FP_my);

    // Calcul de la sensibilité
    double sensibilite_cv = (double) TP_cv/(TP_cv+FN_cv);
    double sensibilite_my = (double) TP_my/(TP_my+FN_my);

    // Calcul du coefficient de similarité DICE 
    double dice_cv = (double) 2*TP_cv/(2*TP_cv+FP_cv+FN_cv);
    double dice_my = (double) 2*TP_my/(2*TP_my+FP_my+FN_my);

    // Affichage des résultats 
    cout << "RESULTATS : " << endl << endl;

    // Affichage de la précision
    cout << "Precision openCV: " << precision_cv << endl;
    cout << "Precision my_kmeans: " << precision_my << endl << endl;

    // Affichage de la précision
    cout << "Sensibilité openCV: " << sensibilite_cv << endl;
    cout << "Sensibilité my_kmeans: " << sensibilite_my << endl << endl;

    // Affichage de DICE
    cout << "DICE openCV: " << dice_cv << endl;
    cout << "DICE my_kmeans: " << dice_my << endl << endl;
    
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
    
    // lecture et initialisation  
    Mat image_ref = imread(groundTruthFilename, IMREAD_COLOR);
    Mat image = imread(imageFilename, IMREAD_COLOR);
    const unsigned int taille=image.rows*image.cols;
    Mat data = image.reshape(1,taille);
    data.convertTo(data, CV_32F);
    Mat1f centers;
    vector<int> labels;

    // segmentation
    TermCriteria criteria=TermCriteria(TermCriteria::EPS+TermCriteria::COUNT, 10, 1.0);
    kmeans(data,k,labels,criteria,3,KMEANS_PP_CENTERS,centers);

    if(k==2){
        for(unsigned int i=0;i<3;i++){
            centers(0,i)=255;
            centers(1,i)=0;
        }
    }

    for(unsigned int i=0;i<taille;i++){
        data.at<float>(i,0)=centers(labels[i],0);
        data.at<float>(i,1)=centers(labels[i],1);
        data.at<float>(i,2)=centers(labels[i],2);
    }

    Mat imagesegmentee = data.reshape(3,image.rows);
    imagesegmentee.convertTo(imagesegmentee,CV_8U);

    // my_kmeans;
    long iters_max=50;
    Mat my_image = my_kmeans(image,k,iters_max);

    // sauvegarde de l'image segmentee
    imwrite("../data/images/Image11_segmentee.jpg", imagesegmentee);
    imwrite("../data/images/My_Image11_segmentee.jpg", my_image);

    // affichage des images
    imshow(imageFilename, image);
    imshow("Image segmentée openCV", imagesegmentee);
    imshow("Image segmentée my_kmeans", my_image);
    
    // qualité de la segmentation par rapport à l'image de référence 
    segmentationQuality(image_ref, my_image, imagesegmentee);

    // attente de réponse de l'utilisateur
    waitKey(0);
    //fermeture des fenetres
    destroyAllWindows();
    return EXIT_SUCCESS;
}
