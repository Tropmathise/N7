/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */
/* 
 * File:   testEdgeList.cpp
 * Author: Simone Gasparini
 *
 * Created on October 25, 2014, 1:26 PM
 */


#include "core.hpp"
#include "ObjModel.hpp"
#include <sstream>
#include <cstdio>
#include <cstdlib>
#include <cassert>

using namespace std;

/*
 * 
 */
int main( int argc, char** argv )
{

    EdgeList list;
    int numTrial;

    if(argc == 2)
    {
        numTrial = atoi(argv[1]);
    }
    else
    {
        numTrial = 1000;
    }

    idxtype maxIdx  = numTrial/5;

    vector<edge> listEdges;
    vector<idxtype> listIdx;

    // fill up the list with random edges
    cout << "Filling up data..." << endl;
    for(size_t i =0; i < numTrial; ++i)
    {
        edge e(rand() % maxIdx, rand() % maxIdx);
        listEdges.push_back(e);
        listIdx.push_back(i);

        list.add(e, i);
    }

    // test
    cout << "Testing..." << endl;
    for(size_t i =0; i < numTrial; ++i)
    {
        edge e = listEdges[i];
        // test it contains the edges we inserted
        assert(list.contains( e ));

        // reflexive test (inverted indices))
        assert(list.contains( edge(e.second, e.first)));

        idxtype res = list.getIndex( e );

        // if the index is different
        if( res != listIdx[i] )
        {
            // then there must be another edge with the same indices in the reversed order
            bool found = false;
            for( size_t j= 0; (j < numTrial) && (!found); ++j )
            {
                // avoid to check for the current edge
                if(j != i )
                {
                    found = (listEdges[j] == e);
                    if(found)
                    {
                        PRINTVAR(e);
                        PRINTVAR(listEdges[j]);
                        PRINTVAR(i);
                        PRINTVAR(j)
                    }
                }
            }
            assert(found);
        }
    }

    cout << "Test passed!" << endl;
}

