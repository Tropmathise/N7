using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System;
using UnityEngine.UI;

public class Projet : MonoBehaviour
{
    
    // Liste des points composant la courbe
    private List<Vector3> ListePoints = new List<Vector3>();
    private List<Vector3> ListePointsSub = new List<Vector3>();
    private List<Quaternion> ListeQuaternions = new List<Quaternion>();
    private List<Quaternion> ListeQuaternionsSub = new List<Quaternion>();

    // Donnees i.e. points cliqués
    public GameObject Donnees;
    public GameObject particle;
    // Coordonnees des points composant le polygone de controle
    private List<float> PolygoneControleX = new List<float>();
    private List<float> PolygoneControleY = new List<float>();
    private List<float> PolygoneControleZ = new List<float>();

    // degres des polynomes par morceaux
    public int degres = 5;
    // nombre d'itération de subdivision
    public int nombreIteration = 5;
    public int nb = 0;
    public Quaternion rotation;

    //////////////////////////////////////////////////////////////////////////
    // fonction : subdivise                                                 //
    // semantique : réalise nombreIteration subdivision pour des polys de   //
    //              degres degres                                           //
    // params : - List<float> X : abscisses des point de controle           //
    //          - List<float> Y : odronnees des point de controle  
    //          - List<float> Z : profondeur des point de controle          //
    // sortie :                                                             //
    //          - (List<float>, List<float>) : points de la courbe          //
    //////////////////////////////////////////////////////////////////////////
    //(List<float>, List<float>, List<float>, List<Quaternion>) subdivise(List<float> X, List<float> Y, List<float> Z, List<Quaternion> Q)
    //{
    //    List<float> Xres = new List<float>();
    //    List<float> Yres = new List<float>();
    //    List<float> Zres = new List<float>();
    //    List<Quaternion> Qres = new List<Quaternion>();

    //    for (int i = 0; i < X.Count; i++)
    //    {
    //        Xres.Add(X[i]);
    //        Xres.Add(X[i]);
    //        Yres.Add(Y[i]);
    //        Yres.Add(Y[i]);
    //        Zres.Add(Z[i]);
    //        Zres.Add(Z[i]);
    //        Qres.Add(Q[i]);
    //        Qres.Add(Q[i]);
    //    }

    //    for (int i = 0; i < nombreIteration; i++)
    //    {
    //        for (int j = 0; j < Xres.Count - 1; j++)
    //        {
    //            Xres[j] = (Xres[j] + Xres[j + 1]) / 2;
    //            Yres[j] = (Yres[j] + Yres[j + 1]) / 2;
    //            Zres[j] = (Zres[j] + Zres[j + 1]) / 2;
    //            Qres[j] = Quaternion.Slerp(Qres[j], Qres[j + 1], 0.5f);
    //        }
    //        Xres.Add((Xres[0] + Xres[Xres.Count - 1]) / 2);
    //        Yres.Add((Yres[0] + Yres[Yres.Count - 1]) / 2);
    //        Zres.Add((Zres[0] + Zres[Zres.Count - 1]) / 2);
    //        Qres.Add(Quaternion.Slerp(Qres[Qres.Count - 1], Qres[0], 0.5f));
    //    }
    //    return (Xres, Yres, Zres, Qres);
    //}
    (List<float>, List<float>, List<float>, List<Quaternion>) subdivise(List<float> X, List<float> Y, List<float> Z, List<Quaternion> Q)
    {
        List<float> Xres = new List<float>(X);
        List<float> Yres = new List<float>(Y);
        List<float> Zres = new List<float>(Z);
        List<Quaternion> Qres = new List<Quaternion>(Q);

        for (int k = 0; k < nombreIteration; k++)
        {
            List<float> Xresult = new List<float>();
            List<float> Yresult = new List<float>();
            List<float> Zresult = new List<float>();
            List<Quaternion> Qresult = new List<Quaternion>();

            for (int i = 0; i < Xres.Count; i++)
            {
                Xresult.Add(Xres[i]);
                Xresult.Add(Xres[i]);
                Yresult.Add(Yres[i]);
                Yresult.Add(Yres[i]);
                Zresult.Add(Zres[i]);
                Zresult.Add(Zres[i]);
                Qresult.Add(Qres[i]);
                Qresult.Add(Qres[i]);
            }
            for (int i = 0; i < degres; i++)
            {
                for (int j = 0; j < Xresult.Count -1; j++)
                {
                    Xresult[j] = (Xresult[j] + Xresult[j + 1]) / 2;
                    Yresult[j] = (Yresult[j] + Yresult[j + 1]) / 2;
                    Zresult[j] = (Zresult[j] + Zresult[j + 1]) / 2;
                    Qresult[j] = Quaternion.Slerp(Qresult[j], Qresult[j + 1], 0.5f);
                }
                Xresult.Add((Xresult[0] + Xresult[Xresult.Count - 1]) / 2);
                Yresult.Add((Yresult[0] + Yresult[Yresult.Count - 1]) / 2);
                Zresult.Add((Zresult[0] + Zresult[Zresult.Count - 1]) / 2);
                Qresult.Add(Quaternion.Slerp(Qresult[Qresult.Count - 1], Qresult[0], 0.5f));
            }
            Xres = Xresult;
            Yres = Yresult;
            Zres = Zresult;
            Qres = Qresult;
        }
        return (Xres, Yres, Zres, Qres);
    }

    void Start()
    {
        // objets
        GameObject objetCylindre = GameObject.Find("Cylinder");
        Vector3 positionObjetCylindre = objetCylindre.transform.position;

        GameObject[] ListeSpheres = GameObject.FindGameObjectsWithTag("Sphere");

        int n = ListeSpheres.Length;

        for (int i = 0; i < n; i++)
        {
            Vector3 position_sphere = ListeSpheres[i].transform.position;
            ListePoints.Add(position_sphere);
            Instantiate(particle, ListePoints[i], Quaternion.identity);
            Vector3 relativPos = positionObjetCylindre - position_sphere;
            ListeQuaternions.Add(Quaternion.LookRotation(relativPos,Vector3.up));
        }

        for (int i = 0; i < ListePoints.Count; i++)
        {
            PolygoneControleX.Add(ListePoints[i].x);
            PolygoneControleY.Add(ListePoints[i].y);
            PolygoneControleZ.Add(ListePoints[i].z);
        }

        //subdivision
        List<float> Xres = new List<float>();
        List<float> Yres = new List<float>();
        List<float> Zres = new List<float>();
        (Xres, Yres, Zres, ListeQuaternionsSub) = subdivise(PolygoneControleX, PolygoneControleY, PolygoneControleZ, ListeQuaternions);

        //trajectoire
        for (int i = 0; i < Zres.Count; i++)
        {
            ListePointsSub.Add(new Vector3(Xres[i], Yres[i], Zres[i]));
        }

    }

    void FixedUpdate()
    {
        if (nb<ListePointsSub.Count)
        {
            transform.position = ListePointsSub[nb];
            transform.rotation = ListeQuaternionsSub[nb];
        } else
        {
            nb = -1;
        } nb++;
    }

    void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.red;
        for (int i = 0; i < ListePointsSub.Count - 1; ++i)
        {
            Gizmos.DrawLine(ListePointsSub[i], ListePointsSub[i + 1]);
        }
        if (ListePointsSub.Count > 0)
        {
            Gizmos.DrawLine(ListePointsSub[ListePointsSub.Count - 1], ListePointsSub[0]);
        } 

        Gizmos.color = Color.blue;
        for (int i = 0; i < ListePoints.Count - 1; ++i)
        {
            Gizmos.DrawLine(ListePoints[i], ListePoints[i + 1]);
        }
        if (ListePoints.Count > 0)
        {
            Gizmos.DrawLine(ListePoints[ListePoints.Count - 1], ListePoints[0]);
        }
    }
}
