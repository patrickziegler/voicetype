cmake_minimum_required(VERSION 3.20)

project(VoiceType LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(sdbus-c++ REQUIRED)

add_subdirectory(service)
