/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

#include "core.hpp"
#include "ObjModel.hpp"
#include <sstream>
#include <cstdio>

#include <unordered_map>

std::unordered_map< int, int > map;


int main(int argc, char **argv)
{
    edge2vertex mylist;


    mylist.insert(std::pair<edge,GLushort>(edge(6,5),6));
    mylist.insert(std::pair<edge,GLushort>(edge(1,2),1));
    mylist.insert(std::pair<edge,GLushort>(edge(2,1),4));
    mylist.insert(std::pair<edge,GLushort>(edge(1,4),5));
    mylist.insert(std::pair<edge,GLushort>(edge(3,5),6));
//     mylist[edge(3,2)] = 10;

    PRINTVAR(mylist);
    PRINTVAR(mylist.size());

    bool res = (mylist.find(edge(5,3))) != mylist.end();
    PRINTVAR(res);

    PRINTVAR(((mylist.find(edge(4,1))) != mylist.end()));
    PRINTVAR(((mylist.find(edge(3,2))) != mylist.end()));
    PRINTVAR(((mylist.find(edge(1,2))) != mylist.end()));
    PRINTVAR(((mylist.find(edge(2,1))) != mylist.end()));

    PRINTVAR(mylist[edge(4,1)]);
    PRINTVAR(mylist[edge(2,1)]);
    PRINTVAR(mylist[edge(3,5)]);
    PRINTVAR(((mylist.find(edge(5,3))) != mylist.end()));
    PRINTVAR(mylist[edge(6,5)]);
    PRINTVAR(((mylist.find(edge(5,6))) != mylist.end()));
    mylist[edge(0,1)]=100;

    PRINTVAR(mylist);

    std::string line("f 34//23 11//65 123//98");
    idxtype a;
    face out;
    std::string b;
//    std::stringstream parser (line);
//    parser >> b
//           >> out.v1 >> b >> a
//           >> out.v2 >> b >> a
//           >> out.v3 >> b >> a;
//    PRINTVAR(parser.fail());
//    std::cout << out << a << b << std::endl;
    PRINTVAR(line);
    PRINTVAR( (sscanf(line.c_str(), "f %u//%u %u//%u %u//%u", &(out.v1), &a, &(out.v2), &a, &(out.v3), &a) == 6) );
    std::cout << out << a << b << std::endl;

    PRINTVAR(v3f(1,2,4)*10.f);
    PRINTVAR(10.f*v3f(1,2,4));

    PRINTVAR((edge(3,5)==edge(3,5)));
    PRINTVAR((edge(3,5)==edge(5,3)));
    PRINTVAR((edge(1,2)==edge(3,5)));

    idxtype idx;

    PRINTVAR((face(1,2,3).containsEdge( edge(3,5), idx )));
    PRINTVAR( idx );
    PRINTVAR((face(1,2,3).containsEdge( edge(2,3), idx )));
    PRINTVAR( idx );
    PRINTVAR((face(1,2,3).containsEdge( edge(3,2), idx )));
    PRINTVAR( idx );
    PRINTVAR((face(1,2,3).containsEdge( edge(0,2), idx )));
    PRINTVAR( idx );
    PRINTVAR((face(1,2,3).containsEdge( edge(3,1), idx )));
    PRINTVAR( idx );
}
