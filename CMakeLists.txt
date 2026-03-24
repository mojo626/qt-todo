cmake_minimum_required(VERSION 3.20)
project(frontend LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Core Quick QuickControls2 REQUIRED)

add_subdirectory(lib/caldav-cpp)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_AUTOMOC ON)
set(QT_QML_GENERATE_QMLLS_INI ON)



qt_add_executable(app 
	src/main.cpp 
	src/caldavclient.cpp 
	src/calendarutil.cpp
	src/weekmodel.cpp
	src/databasemanager.cpp
	src/daymodel.cpp
	include/caldavclient.h
	include/calendarutil.h
	include/weekmodel.h
	include/databasemanager.h
	include/daymodel.h
)

qt_policy(SET QTP0004 NEW)

target_include_directories(app 
	PUBLIC 
		${CMAKE_SOURCE_DIR}/include
)

set_source_files_properties(qml/Icons.qml
    PROPERTIES QT_QML_SINGLETON_TYPE TRUE)


FetchContent_Declare(
  date_src
  GIT_REPOSITORY https://github.com/HowardHinnant/date.git
  GIT_TAG v3.0.4
)

FetchContent_MakeAvailable(date_src)

find_package(Qt6 REQUIRED COMPONENTS Sql)

qt_add_qml_module(app
	URI frontend 
	RESOURCE_PREFIX /
	QML_FILES
		Main.qml
		qml/SideBar.qml
		qml/MainView.qml
		qml/IconButton.qml
		qml/Icons.qml
		qml/MonthView/CalendarMonthView.qml
		qml/TodoView.qml
		qml/CalendarWeekView.qml
		qml/WeekViewDay.qml
		qml/MonthView/MonthViewWeekRow.qml
		qml/MonthView/MonthViewEvents.qml
	RESOURCES
		fonts/MaterialDesignIconsDesktop.ttf
)


target_link_libraries(app
    PRIVATE
		Qt6::Core
		Qt6::Quick
		Qt6::QuickControls2
		Qt6::Sql
		caldav
		date::date
)

target_include_directories(caldav
    PUBLIC
        ${date_src_SOURCE_DIR}/include
)
