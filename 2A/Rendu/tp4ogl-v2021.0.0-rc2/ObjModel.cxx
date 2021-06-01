/**
 * @file ObjModel.cxx
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

#include <algorithm>

/**
 * Computes the angle at vertex baseV formed by the edges connecting it with the
 * vertices v1 and v2 respectively, ie the baseV-v1 and baseV-v2 edges
 * 
 * @brief Computes the angle at vertex
 * @param baseV the vertex at which to compute the angle
 * @param v1 the other vertex of the first edge baseV-v1
 * @param v2 the other vertex of the second edge baseV-v2
 * @return the angle in radiants
 */
float ObjModel::angleAtVertex( const point3d& baseV, const point3d& v1, const point3d& v2 ) const
{
    vec3d e1 = baseV - v1;
    vec3d e2 = baseV - v2;
    //safe acos...
    if ( fabs( (e1).dot( e2 ) / (e1.norm( ) * e2.norm( )) ) >= 1.0f )
    {
        cerr << "warning: using safe acos" << endl;
        return (acos( 1.0f ));
    }
    else
    {
        return ( acos( (e1).dot( e2 ) / (e1.norm( ) * e2.norm( )) ));
    }
}


/**
* Render the model according to the provided parameters
* @param params The rendering parameters
*/
void ObjModel::render( const RenderingParameters &params )
{
    // if we need to draw the original model
    if ( !params.subdivision )
    {
        // draw it
        draw( _vertices, _mesh, _normals, params );
        // draw the normals
        if ( params.normals )
        {
            drawNormals( _vertices, _normals );
        }
    }
    else
    {
        PRINTVAR(params.subdivLevel);
        PRINTVAR(_currentSubdivLevel);
        // before drawing check the current level of subdivision and the required one
        if ( ( _currentSubdivLevel == 0 ) || ( _currentSubdivLevel != params.subdivLevel ) )
        {
            // if they are different apply the missing steps: either restart from the beginning
            // if the required level is less than the current one or apply the missing
            // steps starting from the current one
            vector<point3d> tmpVert;        //!< a temporary list of vertices used in the iterations
            vector<face> tmpMesh;           //!< a temporary mesh used in the iterations

            if(( _currentSubdivLevel == 0 ) || ( _currentSubdivLevel > params.subdivLevel ) )
            {
                // start from the beginning
                _currentSubdivLevel = 0;
                tmpVert = _vertices;
                tmpMesh = _mesh;
            }
            else
            {
                // start from the current level
                tmpVert = _subVert;
                tmpMesh = _subMesh;
            }

            // apply the proper subdivision iterations
            for( ; _currentSubdivLevel < params.subdivLevel; ++_currentSubdivLevel)
            {
                cerr << "[Loop subdivision] iteration " << _currentSubdivLevel << endl;
                loopSubdivision( tmpVert, tmpMesh, _subVert, _subMesh, _subNorm );
                // swap unless it's the last iteration
                if( _currentSubdivLevel < ( params.subdivLevel - 1) )
                {
                    tmpVert = _subVert;
                    tmpMesh = _subMesh;
                }
            }
        }

        draw( _subVert, _subMesh, _subNorm, params );
        if ( params.normals )
        {
            drawNormals( _subVert, _subNorm );
        }
    }
}

/**
 * Draw the model
 * 
 * @param vertices list of vertices
 * @param indices list of faces
 * @param vertexNormals list of normals
 * @param params Rendering parameters
 */
void ObjModel::draw( const std::vector<point3d> &vertices, const std::vector<face> &indices, std::vector<vec3d> &vertexNormals, const RenderingParameters &params ) const
{
    if ( params.solid )
    {
        drawSolid( vertices, indices, vertexNormals, params );
    }
    if ( params.wireframe )
    {
        drawWireframe( vertices, indices, params );
    }

}

void ObjModel::drawSolid( const vector<point3d> &vertices, const vector<face> &indices, vector<vec3d> &vertexNormals, const RenderingParameters &params ) const
{
    if ( params.useIndexRendering )
    {
        drawSmoothFaces( vertices, indices, vertexNormals, params );
    }
    else
    {
        drawFlatFaces( vertices, indices, params );
    }
}

/**
 * Draw the normals at each vertex
 * @param vertices The list of vertices 
 * @param vertexNormals The list of associated normals
 */
void ObjModel::drawNormals( const std::vector<point3d> &vertices, std::vector<vec3d> &vertexNormals ) const
{
    glDisable( GL_LIGHTING );

    glColor3f( 0.8, 0, 0 );
    glLineWidth( 2 );

    for(const auto &v : vertices)
    {
        glBegin( GL_LINES );

        vec3d newP = v + 0.1 * v;
        glVertex3fv( (float*) &v );

        glVertex3f( newP.x, newP.y, newP.z );

        glEnd( );
    }
    glEnable( GL_LIGHTING );
}

/**
 * It scales the model to unitary size by translating it to the origin and
 * scaling it to fit in a unit cube around the origin.
 * 
 * @return the scale factor used to transform the model
 */
float ObjModel::unitizeModel( )
{
    if ( !_vertices.empty( ) && !_mesh.empty( ) )
    {
        //****************************************
        // calculate model width, height, and
        // depth using the bounding box
        //****************************************
        const float w = fabs( _bb.pmax.x - _bb.pmin.x );
        const float h = fabs( _bb.pmax.y - _bb.pmin.y );
        const float d = fabs( _bb.pmax.z - _bb.pmin.z );

        cout << "size: w: " << w << " h " << h << " d " << d << endl;
        //****************************************
        // calculate center of the bounding box of the model
        //****************************************
        const point3d c = (_bb.pmax + _bb.pmin) * 0.5;

        //****************************************
        // calculate the unitizing scale factor as the
        // maximum of the 3 dimensions
        //****************************************
        const float scale = 2.0 / std::max( std::max( w, h ), d );

        cout << "scale: " << scale << " cx " << c.x << " cy " << c.y << " cz " << c.z << endl;

        // translate each vertex wrt to the center and then apply the scaling to the coordinate
        for(auto& v : _vertices)
        {
            //****************************************
            // translate the vertex
            //****************************************
            v.translate( -c.x, -c.y, -c.z );

            //****************************************
            // apply the scaling
            //****************************************
            v.scale( scale );

        }


        //****************************************
        // update the bounding box, ie translate and scale the 6 coordinates
        //****************************************
        _bb.pmax = (_bb.pmax - c) * scale;
        _bb.pmin = (_bb.pmin - c) * scale;


        cout << "New bounding box : pmax=" << _bb.pmax << "  pmin=" << _bb.pmin << endl;

        return scale;

    }

    return 0;
}

void ObjModel::release( ) { }

/**
 * It parses a line of the OBJ file containing a face and it return the result. 
 * NB: it only recover the indices, it discard normal and texture indices
 * 
 * @param toParse the string to parse in the OBJ format for a face (f v/vt/vn v/vt/vn v/vt/vn) and its variants
 * @param out the 3 indices for the face
 * @return true if the parse was successful
 */
bool ObjModel::parseFaceString( const string &toParse, face &out ) const
{
//  PRINTVAR( toParse );
    if ( toParse.c_str( )[0] == 'f' )
    {
        idxtype a;
        // now check the different formats: %d, %d//%d, %d/%d, %d/%d/%d
        if ( strstr( toParse.c_str( ), "//" ) )
        {
            // v//n
            return ( sscanf( toParse.c_str( ), "f %u//%u %u//%u %u//%u", &(out.v1), &a, &(out.v2), &a, &(out.v3), &a ) == 6);
        }
        else if ( sscanf( toParse.c_str( ), "f %u/%u/%u", &a, &a, &a ) == 3 )
        {
            // v/t/n
            return ( sscanf( toParse.c_str( ), "f %u/%u/%u %u/%u/%u %u/%u/%u", &(out.v1), &a, &a, &(out.v2), &a, &a, &(out.v3), &a, &a ) == 9);
        }
        else if ( sscanf( toParse.c_str( ), "f %u/%u", &a, &a ) == 2 )
        {
            // v/t .
            return ( sscanf( toParse.c_str( ), "f %u/%u %u/%u %u/%u", &(out.v1), &a, &(out.v2), &a, &(out.v3), &a ) == 6);
        }
        else
        {
            // v
//            sscanf( toParse.c_str( ), "f %u %u %u", &(out.v1), &(out.v2), &(out.v3) );

//            PRINTVAR( out );
            return ( sscanf( toParse.c_str( ), "f %u %u %u", &(out.v1), &(out.v2), &(out.v3) ) == 3);
        }
    }
    else
    {
        return false;
    }
}


//*****************************************************************************
//*                        DEPRECATED FUNCTIONS
//*****************************************************************************

// to be deprecated

void ObjModel::flatDraw( ) const
{
    glShadeModel( GL_SMOOTH );

    // for each triangle draw the vertices and the normals
    for(const auto &face : _mesh)
    {
        glBegin( GL_TRIANGLES );
        //compute the normal of the triangle
        vec3d n;
        computeNormal( _vertices[face.v1], _vertices[(int) face.v2], _vertices[(int) face.v3], n );
        glNormal3fv( (float*) &n );

        glVertex3fv( (float*) &_vertices[face.v1] );

        glVertex3fv( (float*) &_vertices[face.v2] );

        glVertex3fv( (float*) &_vertices[face.v3] );

        glEnd( );
    }

}

// to be deprecated

void ObjModel::drawWireframe( ) const
{

    drawWireframe( _vertices, _mesh, RenderingParameters( ) );

}

// to be deprecated

void ObjModel::indexDraw( ) const
{
    glShadeModel( GL_SMOOTH );
    //****************************************
    // Enable vertex arrays
    //****************************************
    glEnableClientState( GL_VERTEX_ARRAY );

    //****************************************
    // Enable normal arrays
    //****************************************
    glEnableClientState( GL_NORMAL_ARRAY );

    //****************************************
    // Vertex Pointer to triangle array
    //****************************************
    glEnableClientState( GL_VERTEX_ARRAY );

    //****************************************
    // Normal pointer to normal array
    //****************************************
    glNormalPointer( GL_FLOAT, 0, (float*) &_normals[0] );

    //****************************************
    // Index pointer to normal array
    //****************************************
    glVertexPointer( COORD_PER_VERTEX, GL_FLOAT, 0, (float*) &_vertices[0] );

    //****************************************
    // Draw the triangles
    //****************************************
    glDrawElements( GL_TRIANGLES, _mesh.size( ) * VERTICES_PER_TRIANGLE, GL_UNSIGNED_INT, (idxtype*) & _mesh[0] );

    //****************************************
    // Disable vertex arrays
    //****************************************
    glDisableClientState( GL_VERTEX_ARRAY ); // disable vertex arrays

    //****************************************
    // Disable normal arrays
    //****************************************
    glDisableClientState( GL_NORMAL_ARRAY );
}

// to be deprecated

void ObjModel::drawSubdivision( )
{
    if ( _subMesh.empty( ) || _subNorm.empty( ) || _subVert.empty( ) )
    {
        loopSubdivision( _vertices, _mesh, _subVert, _subMesh, _subNorm );
    }

    glShadeModel( GL_SMOOTH );

    glEnableClientState( GL_NORMAL_ARRAY );
    glEnableClientState( GL_VERTEX_ARRAY );

    glNormalPointer( GL_FLOAT, 0, (float*) &_subNorm[0] );
    glVertexPointer( COORD_PER_VERTEX, GL_FLOAT, 0, (float*) &_subVert[0] );

    glDrawElements( GL_TRIANGLES, _subMesh.size( ) * VERTICES_PER_TRIANGLE, GL_UNSIGNED_SHORT, (idxtype*) & _subMesh[0] );


    glDisableClientState( GL_VERTEX_ARRAY ); // disable vertex arrays
    glDisableClientState( GL_NORMAL_ARRAY );

    drawWireframe( _subVert, _subMesh, RenderingParameters( ) );

}

// to be removed
void ObjModel::applyLoop( const face &t, const std::vector<point3d> &origVert, std::vector<size_t> &valence, std::vector<point3d> &destVert ) const
{
    // 5/8 V + 3/8 sum(V_i))
    // in this case since we are summing each face the other vertices are counted
    // twice, so we use 3/16 instead of 3/8
    valence[t.v1]++;
    destVert[t.v1] += (0.625f * origVert[t.v1] + 0.1875f * origVert[t.v2] + 0.1875f * origVert[t.v3]);
    //    PRINTVAR(valence[t.v1]);

    valence[t.v2]++;
    destVert[t.v2] += (0.625f * origVert[t.v2] + 0.1875f * origVert[t.v1] + 0.1875f * origVert[t.v3]);

    valence[t.v3]++;
    destVert[t.v3] += (0.625f * origVert[t.v3] + 0.1875f * origVert[t.v2] + 0.1875f * origVert[t.v1]);
}
