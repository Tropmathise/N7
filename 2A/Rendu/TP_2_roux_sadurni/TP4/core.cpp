/**
 * @file core.cpp
 * @author  Simone Gasparini <simone.gasparini@enseeiht.fr>
 * @version 1.0
 *
 * @section LICENSE
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * @section DESCRIPTION
 * 
 * The core module providing some helper classes for manipulating mesh data
 *
 */

#include "core.hpp"

#include <cmath>
#include <cassert>
#include <algorithm>
#include <limits>

void v3f::normalize()
{
    const float n = norm();
    if (n > (100.f * std::numeric_limits<float>::epsilon()) )
    {
        x /= n;
        y /= n;
        z /= n;
    }
}

float v3f::dot(const v3f &v) const
{
    return (x*v.x + y*v.y + z*v.z);
}

float v3f::norm() const
{
    return std::sqrt(x*x + y*y + z*z);
}

/**
 * Translate the vector
 * @param x the delta x of the translation
 * @param y the delta y of the translation
 * @param z the delta z of the translation
 */
void v3f::translate( const float &x, const float &y, const float &z )
{
    this->x += x;
    this->y += y;
    this->z += z;
}

void v3f::translate( const v3f &t )
{
    x += t.x;
    y += t.y;
    z += t.z;
}

void v3f::scale( const v3f &t )
{
    x *= t.x;
    y *= t.y;
    z *= t.z;
}

void v3f::scale( const float &x, const float &y, const float &z )
{
    scale(v3f(x,y,z));
}

void v3f::scale( const float &a )
{
    scale(v3f(a,a,a));
}

void v3f::min( const v3f& a )
{
    x = std::min( x, a.x );
    y = std::min( y, a.y );
    z = std::min( z, a.z );
}

void v3f::max( const v3f& a )
{
    x = std::max( x, a.x );
    y = std::max( y, a.y );
    z = std::max( z, a.z );
}

/**
 * Return the minimum value among the 3 elements
 * @return the minimum value
 */
float v3f::min() const
{
    return std::min( std::min( x, y ), z );
}

/**
 * Return the maximum value among the 3 elements
 * @return the maximum value
 */
float v3f::max() const
{
    return std::max( std::max( x, y ), z );
}

v3f v3f::cross(const v3f& v) const
{
    return {y*v.z - z*v.y,
               z*v.x - x*v.z,
               x*v.y - y*v.x};
}

v3f v3f::cross(const float v[3]) const
{
    return {y*v[2] - z*v[1],
               z*v[0] - x*v[2],
               x*v[1] - y*v[0]};
}

// OPERATOR OVERLOADINGS

v3f v3f::operator +(const v3f& a) const
{
    return {x + a.x, y + a.y, z + a.z};
}

v3f& v3f::operator +=(const v3f& a)
{
    x += a.x;
    y += a.y;
    z += a.z;
    return *this;
}

v3f v3f::operator +(const float a[3]) const
{
    return {x + a[0], y + a[1], z + a[2]};
}

v3f& v3f::operator +=(const float a[3])
{
    x += a[0];
    y += a[1];
    z += a[2];
    return *this;
}

v3f v3f::operator +(const float &a) const
{
    return {x + a, y + a, z + a};
}

v3f& v3f::operator +=(const float &a)
{
    x += a;
    y += a;
    z += a;
    return *this;
}

// subtraction

v3f v3f::operator -(const v3f& a) const
{
    return {x - a.x, y - a.y, z - a.z};
}

v3f& v3f::operator -=(const v3f& a)
{
    x -= a.x;
    y -= a.y;
    z -= a.z;
    return *this;
}

v3f v3f::operator -(const float a[3]) const
{
    return {x - a[0], y - a[1], z - a[2]};
}

v3f& v3f::operator -=(const float a[3])
{
    x -= a[0];
    y -= a[1];
    z -= a[2];
    return *this;
}

v3f v3f::operator -(const float &a) const
{
    return {x - a, y - a, z - a};
}

v3f& v3f::operator -=(const float& a)
{
    x -= a;
    y -= a;
    z -= a;
    return *this;
}

// element-wise product

v3f v3f::operator *(const v3f& a) const
{
    return {x * a.x, y * a.y, z * a.z};
}

v3f& v3f::operator *=(const v3f& a)
{
    x *= a.x;
    y *= a.y;
    z *= a.z;
    return *this;
}

v3f v3f::operator *(const float a[3]) const
{
    return {x * a[0], y * a[1], z * a[2]};
}

v3f& v3f::operator *=(const float a[3])
{
    x *= a[0];
    y *= a[1];
    z *= a[2];
    return *this;
}

v3f v3f::operator *(const float &a) const
{
    return {x * a, y * a, z * a};
}

v3f& v3f::operator *=(const float &a)
{
    x *= a;
    y *= a;
    z *= a;
    return *this;
}

// element-wise ratio

v3f v3f::operator /(const v3f& a) const
{
    return {x / a.x, y / a.y, z / a.z};
}
v3f& v3f::operator /=(const v3f& a)
{
    x /= a.x;
    y /= a.y;
    z /= a.z;
    return *this;
}

v3f v3f::operator /(const float a[3]) const
{
    return {x / a[0], y / a[1], z / a[2]};
}
v3f& v3f::operator /=(const float a[3])
{
    x /= a[0];
    y /= a[1];
    z /= a[2];
    return *this;
}

v3f v3f::operator /(const float &a) const
{
    return {x / a, y / a, z / a};
}
v3f& v3f::operator /=(const float &a)
{
    x /= a;
    y /= a;
    z /= a;
    return *this;
}

//**************************** tindex ***********************//


/**
 * Return true if the edge e is contained in the triplet of indices. If it is
 * contained it also return the opposite vertex (ie the index of the vertex not
 * belonging to the edge)
 * 
 * @param[in] e the edge to check
 * @param[out] oppositeVertex If the triplet contain the edge, this will be the (index of the) opposite
 * vertex wrt the edge in the triangle
 * @return true if the edge is contained (the order of the indices does not matter)
 */
bool face::containsEdge(const edge &e, idxtype &oppositeVertex) const
{
    if( edge(v1, v2) == e )
    {
        oppositeVertex = v3;
        return true;
    }
    else if ( edge(v2, v3) == e )
    {
        oppositeVertex = v1;
        return true;
    }
    else if ( edge(v3, v1) == e )
    {
        oppositeVertex = v2;
        return true;
    }
    else
    {
        return false;
    }
}

// ********** SUM
face face::operator +(const face& a) const
{
    return {v1 + a.v1, v2 + a.v2, v3 + a.v3};

}
face& face::operator +=(const face& a)
{
    v1 += a.v1;
    v2 += a.v2;
    v3 += a.v3;
    return *this;
}

face face::operator +(const idxtype &a) const
{
    return {v1 + a, v2 + a, v3 + a};
}
face& face::operator +=(const idxtype &a)
{
    v1 += a;
    v2 += a;
    v3 += a;
    return *this;
}

// ********** DIFFERENCE
face face::operator -(const face& a) const
{
    return {v1 - a.v1, v2 - a.v2, v3 - a.v3};
}
face& face::operator -=(const face& a)
{
    v1 -= a.v1;
    v2 -= a.v2;
    v3 -= a.v3;
    return *this;
}

face face::operator -(const idxtype &a) const
{
    return {v1 - a, v2 - a, v3 - a};
}
face& face::operator -=(const idxtype &a)
{
    v1 -= a;
    v2 -= a;
    v3 -= a;
    return *this;
}

// ********** MULTIPLICATION
face face::operator *(const face& a) const
{
    return {v1 * a.v1, v2 * a.v2, v3 * a.v3};
}
face& face::operator *=(const face& a)
{
    v1 *= a.v1;
    v2 *= a.v2;
    v3 *= a.v3;
    return *this;
}

face face::operator *(const idxtype &a) const
{
    return {v1 * a, v2 * a, v3 * a};
}
face& face::operator *=(const idxtype &a)
{
    v1 *= a;
    v2 *= a;
    v3 *= a;
    return *this;
}

bool face::operator==( const face& r) const
{
    return ( (v1 == r.v1) && (v2 == r.v2) && (v3 == r.v3));
}
/**
 * Two index triplets are different if... they are not equal
 */
bool face::operator!=( const face& r ) const
{
    return ( !(*this == r));
}

/**
 * It checks if the edge e is a boundary edge in the list of triangle. It also 
 * return the indices of the two opposite vertices of the edge or only one of 
 * them if it is a boundary edge
 * 
 * @param[in] e the edge to check
 * @param[in] mesh the list of triangles
 * @param[out] oppVert1 the index of the first opposite vertices (the only one if the edge is a boundary edge)
 * @param[out] oppVert2 the index of the second opposite vertices (only if the edge is not a boundary edge)
 * @return true if the edge is a boundary edge
 */
bool isBoundaryEdge(const edge &e, const std::vector<face> &mesh, idxtype &oppVert1, idxtype &oppVert2 )
{
    bool foundFirst = false;
    bool foundSecond = false;
    for(size_t i = 0; (i < mesh.size()) && ( !(foundFirst && foundSecond)); ++i )
    {
        if(!foundFirst)
        {
            foundFirst = mesh[i].containsEdge(e, oppVert1);
        }
        else
        {
            foundSecond = mesh[i].containsEdge(e, oppVert2);
        }
    }
    // the edge should be in the list, so at least one should be found
    assert(foundFirst);
    return(foundFirst && (!foundSecond));
}
