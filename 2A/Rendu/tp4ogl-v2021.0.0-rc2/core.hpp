/**
 * @file core.hpp
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

#pragma once

// for mac osx
#ifdef __APPLE__
#include <OpenGL/gl.h>
#else
// only for windows
#ifdef _WIN32
#include <windows.h>
#endif
// for windows and linux
#include <GL/gl.h>
#endif

#ifdef __GNUC__
#define DEPRECATED(func) func __attribute__ ((deprecated))
#elif defined(_MSC_VER)
#define DEPRECATED(func) __declspec(deprecated) func
#else
#pragma message("WARNING: You need to implement DEPRECATED for this compiler")
#define DEPRECATED(func) func
#endif //__attribute__ ((deprecated))

#include <vector>
#include <iostream>
#include <string>

#include <unordered_map>
#include <functional>


#define DEBUGGING 1

#if DEBUGGING
#define PRINTVAR( a ) std::cout << #a << " = " << (a) << std::endl << std::endl;
#else
#define PRINTVAR( a )
#endif

/**
 * Renaming, the type of an index is a unsigned int
 */
using idxtype = GLuint;

/**
 * An edge is defined as a pair of indices of the vertices
 */
using edge = std::pair<idxtype, idxtype>;

/**
 * Function to print the values of an edge
 * 
 * @param os the string to fill
 * @param p the edge to print
 * @return the string with the printed value of the edge
 */
inline std::ostream& operator<<( std::ostream& os, const edge& e )
{
    return os << "[" << e.first << "," << e.second << "]";
}

/**
 * It checks whether two edges are equals: two edges are equal if their indices
 * are the same, no matter the order
 * 
 * @param[in] a The first edge
 * @param[in] b The second edge
 * @return true if the edges are equal
 */
inline bool operator==( const edge& a, const edge& b )
{
    return ( ( ( a.first == b.first ) && ( a.second == b.second ) ) ||
            ( ( a.first == b.second ) && ( a.second == b.first ) ) );
}

/**
 * Return the sum of vertex indices of an edge
 * @param[in] e the edge
 * @return the sum of the indices
 */
inline idxtype sum( const edge &e )
{
    return (e.first + e.second );
}

/**
 * return the min index of the two vertices
 * @param[in] e the edge
 * @return the min index
 */
inline idxtype min( const edge &e )
{
    return (( e.first > e.second ) ? ( e.second ) : ( e.first ) );
}

/**
 * Structure used to compare two edges
 */
struct edgeEquivalent
{

    bool operator( ) ( const edge &a, const edge &b ) const
    {
        //      return !( ( (a.first == b.first) && (a.second == b.second) ) ||
        //               ( (a.first == b.second) && (a.second == b.first) ) );

        // two edges are equal either their corresponding elements are equal or
        // they are inverted
        return ( ( ( a.first == b.first ) && ( a.second == b.second ) ) ||
                ( ( a.first == b.second ) && ( a.second == b.first ) ) );
    }
};



// to be used with unordered

struct edgeHash
{

    size_t operator( ) ( const edge &a ) const
    {
        std::hash<std::string> fun;
        return (fun( ( a.first > a.second ) ? ( "v" + std::to_string( a.second ) + "-" + std::to_string( a.first ) ) :
                ( "v" + std::to_string( a.first ) + "-" + std::to_string( a.second ) ) ) );
    }
};


/**
 * An edge list is a map of edges (the keys) and a index of the vertex
 */
using edge2vertex = std::unordered_map< edge, idxtype, edgeHash, edgeEquivalent >;

inline std::ostream& operator<<( std::ostream& os, const edge2vertex & l )
{
    os << std::endl;
    for (const auto &it : l)
        os << "\t" << it.first << "\t" << it.second << std::endl;
    return os;
}

/**
 * A helper class containing the indices of the new vertices added with the subdivision
 * coupled with the edge that has generated them. More specifically, it is a list in which
 * each entry has a key (ie an identifier) and a value: the key is the edge that
 * generate the vertex, the value is the index of the new vertex.
 * The key (ie the edge) is unique, ie an edge cannot generate more than one vertex. The
 * edge is a pair of vertex indices, two edges are the same if they contain the 
 * same pair of vertices, no matter their order, ie
 * edge(v1, v2) == edge(v2, v1)
 * 
 * @see edge
 */
class EdgeList
{
public:

    EdgeList( ) = default;

    /**
     * Add the edge and the index of the new vertex generated on it
     * @param[in] e the edge
     * @param[in] idx the index of the new vertex generated on the edge
     */
    void add( const edge &e, const idxtype &idx )
    {
        list[e] = idx;
    }

    /**
     * Return true if the edge is in the map
     * @param[in] e the edge to search for
     * @return true if the edge is in the map
     */
    bool contains( const edge &e ) const
    {
        return (list.find( e ) != list.end( ) );
    }

    /**
     * Get the vertex index associated to the edge
     * @param e the edge
     * @return the index
     */
    idxtype getIndex( const edge &e )
    {
        return (list[e] );
    }

    friend std::ostream& operator<<( std::ostream& os, const EdgeList& l );


private:
  edge2vertex list;

};

inline std::ostream& operator<<( std::ostream& os, const EdgeList& l )
{
    return (os << l.list );
}

/**************************************************************************/



/**
 * A generic vector of three elements
 */
struct v3f
{
    float x; //!< the first component
    float y; //!< the second component
    float z; //!< the third component

    /**
     * Generic constructor
     * @param x the first element
     * @param y the second element
     * @param z the third element
     */
    v3f( float x, float y, float z ) : x( x ), y( y ), z( z ) { }

    /**
     * Default constructor, everything is initialized to 0
     */
    v3f( ) : x( 0 ), y( 0 ), z( 0 ) { }

    /**
     * Constructor from an array of three elements
     * @param[in] a the array from which to copy the elements
     */
    explicit v3f( const float a[3] ) : x( a[0] ), y( a[1] ), z( a[2] ) { }

    /**
     * Normalize the vector (ie divide by the norm)
     */
    void normalize( );

    /**
     * Return the dot product
     * @param[in] v the other vector
     * @return the dot product
     */
    float dot( const v3f &v ) const;

    /**
     * Return the norm of the vector
     * @return the norm
     */
    float norm( ) const;

    /**
     * Translate the vector
     * @param[in] x the delta x of the translation
     * @param[in] y the delta y of the translation
     * @param[in] z the delta z of the translation
     */
    void translate( const float &x, const float &y, const float &z );

    /**
     * Translate the vector
     * @param[in] t the translation
     */
    void translate( const v3f &t );

    /**
     * Scale each element of the vector by the corresponding value
     * @param[in] t a vector containing a factor scale to apply to each element
     */
    void scale( const v3f &t );

    /**
     * Scale each element of the vector by the corresponding value
     * @param x the scale value on x
     * @param y the scale value on y
     * @param z the scale value on z
     */
    void scale( const float &x, const float& y, const float &z );

    /**
     * Scale each element of the vector by the same value
     * @param a The scalar value to apply to each element
     */
    void scale( const float &a );

    /**
     * Set each element of the current vector to the minimum value wrt another vector
     * @param a the other vector
     */
    void min( const v3f& a );

    /**
     * Return the minimum value among the 3 elements
     * @return the minimum value
     */
    float min( ) const;

    /**
     * Set each element of the current vector to the maximum value wrt another vector
     * @param a the other vector
     */
    void max( const v3f& a );

    /**
     * Return the maximum value among the 3 elements
     * @return the maximum value
     */
    float max( ) const;

    /**
     * Return the cross product of two vectors
     * @param v the other vector
     * @return the cross product
     */
    v3f cross( const v3f& v ) const;

    /**
     * Return the cross product of two vectors
     * @param v the other array
     * @return the cross product
     */
    v3f cross( const float v[3] ) const;

    // element-wise addition

    v3f operator +( const v3f& a ) const;
    v3f& operator +=( const v3f& a );

    v3f operator +( const float a[3] ) const;
    v3f& operator +=( const float a[3] );

    v3f operator +( const float &a ) const;
    v3f& operator +=( const float &a );

    // element-wise subtraction

    v3f operator -( const v3f& a ) const;
    v3f& operator -=( const v3f& a );

    v3f operator -( const float a[3] ) const;
    v3f& operator -=( const float a[3] );

    v3f operator -( const float &a ) const;
    v3f& operator -=( const float &a );

    // element-wise product

    v3f operator *( const v3f& a ) const;
    v3f& operator *=( const v3f& a );

    v3f operator *( const float a[3] ) const;
    v3f& operator *=( const float a[3] );

    v3f operator *( const float &a ) const;
    v3f& operator *=( const float &a );

    // element-wise ratio

    v3f operator /( const v3f& a ) const;
    v3f& operator /=( const v3f& a );

    v3f operator /( const float a[3] ) const;
    v3f& operator /=( const float a[3] );

    v3f operator /( const float &a ) const;
    v3f& operator /=( const float &a );

};

/**
 * Some definitions
 */
using point3d = struct v3f ;
using vec3d = struct v3f;

/**
 * Print the elements of a vector
 * @param os the string to fill with the vector values
 * @param p the vector
 * @return the string with the values
 */
inline std::ostream& operator<<( std::ostream& os, const v3f& p )
{
    return os << "[" << p.x << "," << p.y << "," << p.z << "]";
}

/**
 * Print the elements of a vector of v3f elements
 * @param os the string to fill with the vector elements
 * @param p the vector
 * @return the string with the vector elements
 */
inline std::ostream& operator<<( std::ostream& os, const std::vector<v3f>& p )
{
    os << std::endl;
    for (const auto& v : p)
        os << "\t" << v << std::endl;
    return os;
}



// REFLEXIVE OPERATORS FOR V3F

inline v3f operator +( const float &a, const v3f& p )
{
    return (p + a );
}

inline v3f operator +( const float a[3], const v3f& p )
{
    return (p + a );
}

inline v3f operator -( const float &a, const v3f& p )
{
    return (p - a );
}

inline v3f operator -( const float a[3], const v3f& p )
{
    return (p - a );
}

inline v3f operator *( const float a[3], const v3f& p )
{
    return (p * a );
}

inline v3f operator *( const float &a, const v3f& p )
{
    return (p * a );
}

inline v3f operator /( const float a[3], const v3f& p )
{
    return (p / a );
}

inline v3f operator /( const float &a, const v3f& p )
{
    return (p / a );
}


/**************************************************************************/



/**
 * The face as a triplet of indices
 */
struct face
{
    idxtype v1; //!< the first index
    idxtype v2; //!< the second index
    idxtype v3; //!< the third index

    /**
     * Default constructor, everything set to 0
     */
    face( ) : v1( 0 ), v2( 0 ), v3( 0 ) { }

    /**
     * Constructor from indices
     * @param v1 the first index
     * @param v2 the second index
     * @param v3 the third index
     */
    face( idxtype v1, idxtype v2, idxtype v3 ) : v1( v1 ), v2( v2 ), v3( v3 ) { }

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
    bool containsEdge( const edge &e, idxtype &oppositeVertex ) const;

    face operator +( const face& a ) const;
    face& operator +=( const face& a );

    face operator +( const idxtype &a ) const;
    face& operator +=( const idxtype &a );

    face operator -( const face& a ) const;
    face& operator -=( const face& a );

    face operator -( const idxtype &a ) const;
    face& operator -=( const idxtype &a );

    face operator *( const face& a ) const;
    face& operator *=( const face& a );

    face operator *( const idxtype &a ) const;
    face& operator *=( const idxtype &a );

    /**
     * Two index triplets are equal if their corresponding elements are equal
     */
    bool operator==( const face& rhs ) const;
    /**
     * Two index triplets are different if... they are not equal
     */
    bool operator!=( const face& rhs ) const;
};

/**
 * Print the face values on a string
 * @param os the string to fill with the values
 * @param p the face to print
 * @return the string filled with the values
 */
inline std::ostream& operator<<( std::ostream& os, const face& p )
{
    return os << "[" << p.v1 << "," << p.v2 << "," << p.v3 << "]";
}

/**
 * Print a vector of faces on a string
 * @param[in,out] os the string to fill with the faces
 * @param[in] p the vector of faces to print
 * @return the string filled with the faces
 */
inline std::ostream& operator<<( std::ostream& os, const std::vector<face>& p )
{
    os << std::endl;
    for (auto v : p)
        os << "\t" << v << std::endl;
    return os;
}

/**
 * It checks if the edge e is a boundary edge in the list of triangle. It also 
 * return the indices of the two opposite vertices of the edge or only one of 
 * them if it is a boundary edge
 * 
 * @param[in] e the edge to check
 * @param[in] triangleList the list of triangles
 * @param[out] oppVert1 the index of the first opposite vertices (the only one if the edge is a boundary edge)
 * @param[out] oppVert2 the index of the second opposite vertices (only if the edge is not a boundary edge)
 * @return true if the edge is not a boundary edge
 */
bool isBoundaryEdge( const edge &e, const std::vector<face> &triangleList, idxtype &oppVert1, idxtype &oppVert2 );

