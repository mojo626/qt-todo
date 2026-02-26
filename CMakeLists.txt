cmake_minimum_required(VERSION 3.20)
project(frontend LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Widgets)

# Tell CMake where your installed library is
#list(APPEND CMAKE_PREFIX_PATH "$ENV{HOME}/local/caldav")

#find_package(caldav CONFIG REQUIRED)

add_executable(app main.cpp)

target_link_libraries(app
    PRIVATE
        Qt6::Widgets
		#caldav::caldav
)
