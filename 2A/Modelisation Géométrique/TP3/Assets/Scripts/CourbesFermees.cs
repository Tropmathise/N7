using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CourbesFermees : MonoBehaviour
{
    // Liste des points composant la courbe
    private List<Vector3> ListePoints = new List<Vector3>();
    // Donnees i.e. points cliqués
    public GameObject Donnees;
    // Coordonnees des points composant le polygone de controle
    private List<float> PolygoneControleX = new List<float>();
    private List<float> PolygoneControleY = new List<float>();

    // degres des polynomes par morceaux
    public int degres = 5;
    // nombre d'itération de subdivision
    public int nombreIteration = 5;

    //////////////////////////////////////////////////////////////////////////
    // fonction : subdivise                                                 //
    // semantique : réalise nombreIteration subdivision pour des polys de   //
    //              degres degres                                           //
    // params : - List<float> X : abscisses des point de controle           //
    //          - List<float> Y : odronnees des point de controle           //
    // sortie :                                                             //
    //          - (List<float>, List<float>) : points de la courbe          //
    //////////////////////////////////////////////////////////////////////////
    (List<float>, List<float>) subdivise(List<float> X, List<float> Y) {
        List<float> Xres = new List<float>();
        List<float> Yres = new List<float>();


        for (int i=0; i< X.Count; i++)
        {
            Xres.Add(X[i]);
            Xres.Add(X[i]);
            Yres.Add(Y[i]);
            Yres.Add(Y[i]);
        }

        for (int i=0; i < nombreIteration; i++)
        {
            for (int j = 0; j < Xres.Count-1; j++)
            {
                Xres[j] = (Xres[j] + Xres[j + 1]) / 2;
                Yres[j] = (Yres[j] + Yres[j + 1]) / 2;
            }
            Xres.Add((Xres[0] + Xres[Xres.Count - 1]) / 2);
            Yres.Add((Yres[0] + Yres[Yres.Count - 1]) / 2);
        }
        return (Xres, Yres);
    }

    //////////////////////////////////////////////////////////////////////////
    //////////////////////////// NE PAS TOUCHER //////////////////////////////
    //////////////////////////////////////////////////////////////////////////

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
                
                List<float> Xres = new List<float>();
                List<float> Yres = new List<float>();

                (Xres, Yres) = subdivise(ListePointsCliques.X,ListePointsCliques.Y);
                for (int i = 0; i < Xres.Count; ++i) {
                    ListePoints.Add(new Vector3(Xres[i],-4.0f,Yres[i]));
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
        if (PolygoneControleX.Count > 0 ) {
            Gizmos.DrawLine(new Vector3(PolygoneControleX[PolygoneControleX.Count - 1],-4.0f, PolygoneControleY[PolygoneControleY.Count - 1]), new Vector3(PolygoneControleX[0], -4.0f, PolygoneControleY[0]));
        }

        Gizmos.color = Color.blue;
        for (int i = 0; i < ListePoints.Count - 1; ++i)
        {
            Gizmos.DrawLine(ListePoints[i], ListePoints[i + 1]);
        }
        if (ListePoints.Count > 0 ) {
            Gizmos.DrawLine(ListePoints[ListePoints.Count - 1], ListePoints[0]);
        }
    }
}
