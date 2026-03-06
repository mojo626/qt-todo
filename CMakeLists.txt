cmake_minimum_required(VERSION 3.20)
project(frontend LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Quick QuickControls2 REQUIRED)

add_subdirectory(lib/caldav-cpp)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_AUTOMOC ON)
set(QT_QML_GENERATE_QMLLS_INI ON)


qt_add_executable(app src/main.cpp src/caldavclient.cpp)

qt_add_qml_module(app
	URI frontend 
	RESOURCE_PREFIX /
	QML_FILES
	Main.qml
)


target_link_libraries(app
    PRIVATE
		Qt6::Core
		Qt6::Quick
		Qt6::QuickControls2
		caldav
)
