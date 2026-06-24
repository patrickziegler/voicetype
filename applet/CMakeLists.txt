find_package(Qt6 REQUIRED COMPONENTS Qml DBus)

find_package(ECM REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings)

find_package(KF6 REQUIRED COMPONENTS Config)
find_package(Plasma REQUIRED)

set(TARGET_NAME org.kde.voicetype)

plasma_add_applet(${TARGET_NAME}
    QML_SOURCES
        qml/FullRepresentation.qml
        qml/main.qml
        qml/Toolbar.qml
    CPP_SOURCES
        voicetypecontrol.cpp
        voicetypecontrol.hpp
    GENERATE_APPLET_CLASS
)

target_link_libraries(${TARGET_NAME} PRIVATE Qt6::DBus)
