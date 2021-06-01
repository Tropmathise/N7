using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

//////////////////////////////////////////////////////////////////////////
///////////////// Classe qui gère la subdivision via DCJ /////////////////
//////////////////////////////////////////////////////////////////////////
public class DeCasteljauSubdivision : MonoBehaviour
{
    // Pas d'échantillonage pour affichage
    public float pas = 1 / 100;
    // Nombre de subdivision dans l'algo de DCJ
    public int NombreDeSubdivision = 3;
    // Liste des points composant la courbe
    private List<Vector3> ListePoints = new List<Vector3>();
    // Donnees i.e. points cliqués
    public GameObject Donnees;
    // Coordonnees des points composant le polygone de controle
    private List<float> PolygoneControleX = new List<float>();
    private List<float> PolygoneControleY = new List<float>();

    //////////////////////////////////////////////////////////////////////////
    // fonction : DeCasteljauSub                                            //
    // semantique : renvoie la liste des points composant la courbe         //
    //              approximante selon un nombre de subdivision données     //
    // params : - List<float> X : abscisses des point de controle           //
    //          - List<float> Y : odronnees des point de controle           //
    //          - int nombreDeSubdivision : nombre de subdivision           //
    // sortie :                                                             //
    //          - (List<float>, List<float>) : liste des abscisses et liste //
    //            des ordonnées des points composant la courbe              //
    //////////////////////////////////////////////////////////////////////////
    //(List<float>, List<float>) DeCasteljauSub(List<float> X, List<float> Y, int nombreDeSubdivision)
    //{
    //    List<float> XSortie = new List<float>(X);
    //    List<float> YSortie = new List<float>(Y);

    //    for (int i = 0; i < nombreDeSubdivision; i++)
    //    {
    //        for (int j = 0; j < XSortie.Count - 1; j++)
    //        {
    //            XSortie[j] = XSortie[j] / 2 + XSortie[j + 1] / 2;
    //            YSortie[j] = YSortie[j] / 2 + YSortie[j + 1] / 2;
    //        }
    //        //XSortie.Insert(0, XSortie[0]);
    //        //YSortie.Insert(0, YSortie[0]);
    //        XSortie.RemoveAt(XSortie.Count-1);
    //        YSortie.RemoveAt(YSortie.Count-1);
    //    }

    //    return (XSortie, YSortie);
    //}

    (List<float>, List<float>) DeCasteljauSub(List<float> X, List<float> Y, int nombreDeSubdivision)
    {
        List<float> XSortie = new List<float>();
        List<float> YSortie = new List<float>();

        List<float> Xg = new List<float>();
        List<float> Xd = new List<float>();
        List<float> Yd = new List<float>();
        List<float> Yg = new List<float>();
        List<Vector2> list_vect = new List<Vector2>();
        float t = 0.5f;

        for (int i = 0; i < X.Count; i++)
        {
            list_vect.Add(new Vector2(X[i], Y[i]));
        }
        Xg.Add(X[0]);
        Yg.Add(Y[0]);
        Xd.Add(X[X.Count - 1]);
        Yd.Add(Y[Y.Count - 1]);

        for (int i = 1; i < X.Count; i++)
        {
            for (int j = 0; j < X.Count - i; j++)
            {
                list_vect[j] = (1-t) * list_vect[j] + t * list_vect[j + 1];
            }
            Xg.Add(list_vect[0][0]);
            Yg.Add(list_vect[0][1]);
            Xd.Insert(0, list_vect[list_vect.Count - i - 1][0]);
            Yd.Insert(0, list_vect[list_vect.Count - i - 1][1]);
        }
        if (nombreDeSubdivision != 1)
        {
            (List<float>, List<float>) subG = DeCasteljauSub(Xg, Yg, nombreDeSubdivision - 1);
            (List<float>, List<float>) subD = DeCasteljauSub(Xd, Yd, nombreDeSubdivision - 1);
            XSortie.AddRange(subG.Item1);
            XSortie.AddRange(subD.Item1);
            YSortie.AddRange(subG.Item2);
            YSortie.AddRange(subD.Item2);
        }
        else
        {
            XSortie.AddRange(Xg);
            XSortie.AddRange(Xd);
            YSortie.AddRange(Yg);
            YSortie.AddRange(Yd);
        }
        return (XSortie, YSortie);

    }


        //////////////////////////////////////////////////////////////////////////
        //////////////////////////// NE PAS TOUCHER //////////////////////////////
        //////////////////////////////////////////////////////////////////////////
        void Start()
    {

    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Return))
        {
            var ListePointsCliques = GameObject.Find("Donnees").GetComponent<Points>();
            if (ListePointsCliques.X.Count > 0)
            {
                for (int i = 0; i < ListePointsCliques.X.Count; ++i)
                {
                    PolygoneControleX.Add(ListePointsCliques.X[i]);
                    PolygoneControleY.Add(ListePointsCliques.Y[i]);
                }
                List<float> XSubdivision = new List<float>();
                List<float> YSubdivision = new List<float>();

                (XSubdivision, YSubdivision) = DeCasteljauSub(ListePointsCliques.X, ListePointsCliques.Y, NombreDeSubdivision);
                for (int i = 0; i < XSubdivision.Count; ++i)
                {
                    ListePoints.Add(new Vector3(XSubdivision[i], -4.0f, YSubdivision[i]));
                }
            }

        }
    }

    void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.red;
        for (int i = 0; i < PolygoneControleX.Count - 1; ++i)
        {
            Gizmos.DrawLine(new Vector3(PolygoneControleX[i], -4.0f, PolygoneControleY[i]), new Vector3(PolygoneControleX[i + 1], -4.0f, PolygoneControleY[i + 1]));
        }

        Gizmos.color = Color.blue;
        for (int i = 0; i < ListePoints.Count - 1; ++i)
        {
            Gizmos.DrawLine(ListePoints[i], ListePoints[i + 1]);
        }
    }
}
