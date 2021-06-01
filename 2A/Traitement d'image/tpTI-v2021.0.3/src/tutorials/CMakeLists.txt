#########################################################
#
# OPENCV TUTORIALS 
#
#########################################################

add_executable( display_image display_image.cpp )
target_link_libraries( display_image ${OpenCV_LIBS} )

add_executable( load_modify_image load_modify_image.cpp )
target_link_libraries( load_modify_image ${OpenCV_LIBS} )

add_executable( mat_the_basic_image_container mat_the_basic_image_container.cpp )
target_link_libraries( mat_the_basic_image_container ${OpenCV_LIBS} )


add_custom_target( tutorials DEPENDS load_modify_image display_image mat_the_basic_image_container )
