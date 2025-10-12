cmake_minimum_required(VERSION 3.16) 
project(robot_dog)

set(unitree_sdk2_DIR /opt/unitree_robotics/lib/cmake/unitree_sdk2)
find_package(unitree_sdk2)

include_directories(/opt/unitree_robotics/include)
include_directories(/opt/unitree_robotics/include/ddscxx)

add_executable(dog_walk src/please_walk.cpp)
target_link_libraries(dog_walk unitree_sdk2)

