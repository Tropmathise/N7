using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

public class SurfaceBezierPT : MonoBehaviour
{
    public GameObject particle;
    public float[,] X;
    public float[,] Hauteurs;
    public float[,] Z;
    public bool autoGenerateGrid;
    public float pas = 0.01f;
    private List<List<Vector3>> ListePoints = new List<List<Vector3>>();

    void buildSurfaceBezierPT()
    {
        //lignes
        for (float i=0; i<=1; i += pas)
        {
            List<Vector3> bezier_i = new List<Vector3>();
            for (float j =0; j <=1; j += pas)
            {
                bezier_i.Add(surface(i, j));
            }
            ListePoints.Add(bezier_i);
        }
        //colonnes
        for (float i = 0; i <= 1; i += pas)
        {
            List<Vector3> bezier_i = new List<Vector3>();
            for (float j = 0; j <= 1; j += pas)
            {
                bezier_i.Add(surface(j, i));
            }
            ListePoints.Add(bezier_i);
        }
    }

    float buildBernstein(int n, int k, float t)
    {
        return (float)(KparmiN(k, n) * Math.Pow(t, k) * Math.Pow(1 - t, n - k));
    }

    Vector3 surface(float u, float v)
    {
        Vector3 S = new Vector3();
        int m = X.GetLength(0) - 1;
        int n = X.GetLength(1) - 1;
        for (int i = 0; i <= m; i++)
        {
            for(int j = 0; j <= n; j++)
            {
                float lbda = buildBernstein(m, i, u) * buildBernstein(n, j, v);
                S.x += lbda * X[i, j];
                S.y += lbda * Hauteurs[i, j];
                S.z += lbda * Z[i, j];
            }
        }
        return S;
    }

    long KparmiN(int k, int n)
    {

        decimal result = 1;
        for (int i = 1; i <= k; i++)
        {
            result *= n - (k - i);
            result /= i;
        }
        return (long)result;
    }


    void Start()
    {
        if (autoGenerateGrid)
        {
            int n = 5;
            X = new float[5, 5];
            Hauteurs = new float[5, 5];
            Z = new float[5, 5];
            for (int i = 0; i < n; ++i)
            {
                X[i, 0] = 0.00f;
                X[i, 1] = 0.25f;
                X[i, 2] = 0.50f;
                X[i, 3] = 0.75f;
                X[i, 4] = 1.00f;

                Z[0, i] = 0.00f;
                Z[1, i] = 0.25f;
                Z[2, i] = 0.50f;
                Z[3, i] = 0.75f;
                Z[4, i] = 1.00f;
            }
            for (int i = 0; i < n; ++i)
            {
                for (int j = 0; j < n; ++j)
                {
                    float XC2 = (X[i, j] - (1.0f / 2.0f)) * (X[i, j] - (1.0f / 2.0f));
                    float ZC2 = (Z[i, j] - (1.0f / 2.0f)) * (Z[i, j] - (1.0f / 2.0f));
                    Hauteurs[i, j] = (float)Math.Exp(-(XC2 + ZC2));
                    Instantiate(particle, new Vector3(X[i, j], Hauteurs[i, j], Z[i, j]), Quaternion.identity);
                }
            }
        }
        else
        {

        }
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Return))
        {
            buildSurfaceBezierPT();
        }
    }

    void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.blue;
        if (autoGenerateGrid)
        {

            for (int j = 0; j < ListePoints.Count; ++j)
            {
                for (int i = 0; i < ListePoints[j].Count - 1; ++i)
                {
                    Gizmos.DrawLine(ListePoints[j][i], ListePoints[j][i + 1]);
                }
            }
        }
    }
}
