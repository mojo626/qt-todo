cmake_minimum_required(VERSION 3.20)
project(frontend LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Quick REQUIRED)

# Tell CMake where your installed library is
#list(APPEND CMAKE_PREFIX_PATH "$ENV{HOME}/local/caldav")

#find_package(caldav CONFIG REQUIRED)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(QT_QML_GENERATE_QMLLS_INI ON)

add_subdirectory(lib/MMaterial)
set_target_properties(MMaterialLib PROPERTIES AUTOMOC ON)

qt_add_executable(app main.cpp qml.qrc)

qt_add_qml_module(app
    URI frontend 
    QML_FILES
        main.qml
)
target_link_libraries(app
    PRIVATE
		Qt6::Core
		Qt6::Quick
		MMaterialLib
		#caldav::caldav
)
