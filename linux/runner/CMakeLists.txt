cmake_minimum_required(VERSION 3.13)
project(runner LANGUAGES CXX)

add_executable(${BINARY_NAME}
        "main.cc"
        "my_application.cc"
        "${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc"
)

apply_standard_settings(${BINARY_NAME})

# Thêm định nghĩa preprocessor cho application ID và flavor
add_definitions(-DAPPLICATION_ID="${APPLICATION_ID}")
if(DEFINED FLUTTER_APP_FLAVOR AND NOT FLUTTER_APP_FLAVOR STREQUAL "")
    add_definitions(-DFLUTTER_APP_FLAVOR="${FLUTTER_APP_FLAVOR}")
endif()

target_link_libraries(${BINARY_NAME} PRIVATE flutter)
target_link_libraries(${BINARY_NAME} PRIVATE PkgConfig::GTK)

target_include_directories(${BINARY_NAME} PRIVATE "${CMAKE_SOURCE_DIR}")