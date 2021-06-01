using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//////////////////////////////////////////////////////////////////////////
///////////////// Classe qui gère l'évaluation via DCJ ///////////////////
//////////////////////////////////////////////////////////////////////////
public class DeCasteljauEvaluation : MonoBehaviour
{
    // Pas d'échantillonage construire la parametrisation
    public float pas = 1 / 100;
    // Liste des points composant la courbe
    private List<Vector3> ListePoints = new List<Vector3>();
    // Donnees i.e. points cliqués
    public GameObject Donnees;
    // Coordonnees des points composant le polygone de controle
    private List<float> PolygoneControleX = new List<float>();
    private List<float> PolygoneControleY = new List<float>();
    
    //////////////////////////////////////////////////////////////////////////
    // fonction : buildEchantillonnage                                       //
    // semantique : construit un échantillonnage regulier                    //
    // params : aucun                                                      //
    // sortie :                                                             //
    //          - List<float> tToEval : échantillonnage regulier             //
    //////////////////////////////////////////////////////////////////////////
        List<float> buildEchantillonnage()
        {
            // Echantillonage des pas temporels
            List<float> tToEval = new List<float>();
            int nbElem = (int)(1 / pas);
            // Construction des pas temporels
            for (int i = 0; i < nbElem; i++)
            {
                tToEval.Add((float)i * (float)pas);
            }
            tToEval.Add(1);
            return tToEval;
        }

   //////////////////////////////////////////////////////////////////////////
    // fonction : DeCasteljau                                               //
    // semantique : renvoie le point approxime via l'aglgorithme de DCJ     //
    //              pour une courbe définie par les points de controle      //
    //              (X,Y) à l'instant t                                     //
    // params : - List<float> X : abscisses des point de controle           //
    //          - List<float> Y : odronnees des point de controle           //
    //          - float t : temps d'approximation                           //
    // sortie :                                                             //
    //          - Vector2 : point atteint au temps t                        //
    //////////////////////////////////////////////////////////////////////////
    Vector2 DeCasteljau(List<float> X, List<float> Y, float t)
    {

        List<float> Xi = new List<float>(X);
        List<float> Yi = new List<float>(Y);
        for (int j = 1; j < X.Count; j++)
        {
            for (int k = 0; k < X.Count - j; k++)
            {
                Xi[k] = (1-t) * Xi[k] + t * Xi[k + 1];
                Yi[k] = (1-t) * Yi[k] + t * Yi[k + 1];
            }
        }
        return new Vector2(Xi[0], Yi[0]);
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

                List<float> T = buildEchantillonnage();
                Vector2 point = new Vector2();
                foreach (float t in T)
                {
                    point = DeCasteljau(ListePointsCliques.X, ListePointsCliques.Y, t);
                    ListePoints.Add(new Vector3(point.x,-4.0f,point.y));
                }
            }
        }
    }

    void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.red;
        for (int i = 0; i < PolygoneControleX.Count - 1; ++i)
        {
            Gizmos.DrawLine(new Vector3(PolygoneControleX[i],-4.0f, PolygoneControleY[i]), new Vector3(PolygoneControleX[i + 1], -4.0f, PolygoneControleY[i + 1]));
        }

        Gizmos.color = Color.blue;
        for (int i = 0; i < ListePoints.Count - 1; ++i)
        {
            Gizmos.DrawLine(ListePoints[i], ListePoints[i + 1]);
        }
    }
}
