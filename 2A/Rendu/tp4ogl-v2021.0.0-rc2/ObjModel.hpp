/**
 * @file ObjModel.hpp
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
 * Simple Class to load and draw 3D objects from OBJ files
 * Using triangles and normals as static object. No texture mapping. 
 * OBJ files must be triangulated!!!
 *
 */


#pragma once

#include "core.hpp"

#include <vector>
#include <ostream>
#include <cmath>


#define VERTICES_PER_TRIANGLE 3
#define COORD_PER_VERTEX 3
#define TOTAL_FLOATS_IN_TRIANGLE (VERTICES_PER_TRIANGLE*COORD_PER_VERTEX)



/**
 * A structure that model the bounding box
 */
typedef struct BoundingBox
{
    point3d pmax;    //!<the maximum point of the bounding box
    point3d pmin;    //!<the minimum point of the bounding box

    BoundingBox() :
    pmax(point3d()),
    pmin(point3d()) { }

    BoundingBox(const point3d &p) :
    pmax(p),
    pmin(p) { }

    /**
     * Add a point to the bounding box. Its coordinates are taken into account
     * and the limits of the bounding box updated accordingly
     * @param p the point to add
     */
    void add(const point3d &p)
    {
        pmax.max(p);
        pmin.min(p);
    }

    /**
     * Set the bounding box to the given point
     * @param p the point
     */
    void set(const point3d &p)
    {
        pmax = p;
        pmin = p;
    }

} BoundingBox;


struct RenderingParameters
{
    bool wireframe{true};                   //!< wireframe on/off
    bool solid{true};                       //!< draw the mesh on/off
    bool useIndexRendering{false};          //!< use opengl drawElements on/off
    bool subdivision{false};                //!< subdivision on/off
    bool smooth{false};                     //!< GL_SMOOTH on/off
    bool normals{false};                    //!< show normals on/off
    unsigned short subdivLevel{1};          //!< number of subdivision level

    RenderingParameters() = default;

};

/**
 * The class containing and managing the 3D model 
 */
class ObjModel
{
private:

    std::vector<face> _mesh;                //!< Stores the vertex indices for the triangles
    std::vector<point3d> _vertices;         //!< Stores the vertices
    std::vector<vec3d> _normals;            //!< Stores the normals for the triangles

    // Subdivision
    std::vector<face> _subMesh;             //!< Stores the vertex indices for the triangles
    std::vector<point3d> _subVert;          //!< Stores the vertices
    std::vector<vec3d> _subNorm;            //!< Stores the normals for the triangles

    BoundingBox _bb;                        //!< the current bounding box of the model

    unsigned short _currentSubdivLevel{};   //!< the current subdivision level

public:
    ObjModel() = default;

    /**
     * Calculate the normal of a triangular face defined by three points
     *
     * @param[in] v1 the first vertex
     * @param[in] v2 the second vertex
     * @param[in] cv3 the third vertex
     * @param[out] norm the normal
     */
    void computeNormal(const point3d& v1, const point3d& v2, const point3d& v3, vec3d &norm) const;

    /**
     * Computes the angle at vertex baseV formed by the edges connecting it with the
     * vertices v1 and v2 respectively, ie the baseV-v1 and baseV-v2 edges
     *
     * @brief Computes the angle at vertex
     * @param[in] baseV the vertex at which to compute the angle
     * @param[in] v1 the other vertex of the first edge baseV-v1
     * @param[in] v2 the other vertex of the second edge baseV-v2
     * @return the angle in radiants
     */
    float angleAtVertex(const point3d& v1, const point3d& v2, const point3d& v3) const;

    /**
     * Load the OBJ data from file
     * @param[in] filename The name of the OBJ file
     * @return 0 if everything went well
     */
    int load(char *filename);

    /**
     * Render the model according to the provided parameters
     * @param params The rendering parameters
     */
    void render(const RenderingParameters &params = RenderingParameters());

    /**
     * Release the model
     */
    void release();

    /**
     * It scales the model to unitary size by translating it to the origin and
     * scaling it to fit in a unit cube around the origin.
     *
     * @return the scale factor used to transform the model
     */
    float unitizeModel();


private:
    /**
    * Draw the model
    *
    * @param[in] vertices list of vertices
    * @param[in] indices list of faces
    * @param[in] vertexNormals list of normals
    * @param[in] params Rendering parameters
    */
    void draw(const std::vector<point3d> &vertices, const std::vector<face> &indices, std::vector<vec3d> &vertexNormals, const RenderingParameters &params) const;

    void drawSolid(const std::vector<point3d> &vertices, const std::vector<face> &indices, std::vector<vec3d> &vertexNormals, const RenderingParameters &params) const;

    /**
    * Draw the wireframe of the model
    *
    * @param vertices The list of vertices
    * @param mesh The mesh as a list of faces, each face is a tripleIndex of vertex indices
    * @param params The rendering parameters
    */
    void drawWireframe(const std::vector<point3d> &vertices, const std::vector<face> &indices, const RenderingParameters &params) const;

    /**
     * Draw the model using the vertex indices and using a single normal for each vertex
     *
     * @param vertices The vertices
     * @param indices The list of the faces, each face containing the 3 indices of the vertices
     * @param vertexNormals The list of normals associated to each vertex
     * @param params The rendering parameters
     */
    void drawSmoothFaces(const std::vector<point3d> &vertices, const std::vector<face> &indices, std::vector<vec3d> &vertexNormals, const RenderingParameters &params) const;

    /**
    * Draw the faces using the computed normal of each face
    *
    * @param vertices The list of vertices
    * @param mesh The list of face, each face containing the indices of the vertices
    * @param params The rendering parameters
    */
    void drawFlatFaces(const std::vector<point3d> &vertices, const std::vector<face> &indices, const RenderingParameters &params) const;
    /**
    * Draw the normals at each vertex
    * @param vertices The list of vertices
    * @param vertexNormals The list of associated normals
    */
    void drawNormals(const std::vector<point3d> &vertices, std::vector<vec3d> &vertexNormals) const;


    /////////////////////////////
    // DEPRECATED METHODS
    DEPRECATED(void drawSubdivision());
    DEPRECATED(void indexDraw() const);
    DEPRECATED(void flatDraw() const);
    DEPRECATED(void drawWireframe() const);



private:

    /**
     * Compute the subdivision of the input mesh by applying one step of the Loop algorithm
     *
     * @param[in] origVert The list of the input vertices
     * @param[in] origMesh The input mesh (the vertex indices for each face/triangle)
     * @param[out] destVert The list of the new vertices for the subdivided mesh
     * @param[out] destMesh The new subdivided mesh (the vertex indices for each face/triangle)
     * @param[out] destNorm The new list of normals for each new vertex of the subdivided mesh
     */
    void loopSubdivision(const std::vector<point3d> &origVert, const std::vector<face> &origMesh, std::vector<point3d> &destVert, std::vector<face> &destMesh, std::vector<vec3d> &destNorm) const;


    /**
     * For a given edge it returns the index of the new vertex created on its middle point. If such vertex already exists it just returns the
     * its index; if it does not exist it creates it in vertList along it's normal and return the index
     * @brief ObjModel::getNewVertex
     * @param e the edge
     * @param currFace the current triangle containing the edge e
     * @param vertList the list of vertices
     * @param indices the list of triangles
     * @param normList the list of normals associated to the vertices
     * @param newVertList The list of the new vertices added so far
     * @return the index of the new vertex
     * @see EdgeList
     */
    idxtype getNewVertex(const edge &e, std::vector<point3d> &vertList, const std::vector<face> &mesh, EdgeList &newVertList) const;

    /**
     * It parses a line of the OBJ file containing a face and it return the result.
     * NB: it only recover the indices, it discard normal and texture indices
     *
     * @param toParse the string to parse in the OBJ format for a face (f v/vt/vn v/vt/vn v/vt/vn) and its variants
     * @param out the 3 indices for the face
     * @return true if the parse was successful
     */
    bool parseFaceString(const std::string &toParse, face &out) const;

    DEPRECATED(void applyLoop(const face &t, const std::vector<point3d> &orig, std::vector<size_t> &valence, std::vector<point3d> &dest) const);

};
