find_package(sdbus-c++ REQUIRED)

add_executable(voicetype-service
    main.cpp
)

target_link_libraries(voicetype-service
    PRIVATE
        sdbus-c++
)
