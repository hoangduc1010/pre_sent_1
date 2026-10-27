cmake_minimum_required(VERSION 3.14)
project(runner LANGUAGES CXX)

# Thêm: Cấu hình tiêu đề và icon theo flavor trước khi tạo executable
if(DEFINED FLUTTER_APP_FLAVOR)
    if(FLUTTER_APP_FLAVOR STREQUAL "staging")
        set(RUNNER_APP_ICON "app_icon.ico")
        set(WINDOW_TITLE "pre_sen (Staging)")
    elseif(FLUTTER_APP_FLAVOR STREQUAL "production")
        set(RUNNER_APP_ICON "app_icon.ico")
        set(WINDOW_TITLE "pre_sen")
    endif()
else()
    set(RUNNER_APP_ICON "app_icon.ico")
    set(WINDOW_TITLE "${BINARY_NAME}")
endif()

# Thêm: Sinh file mã nguồn từ template .in tại thời điểm build
configure_file(
        "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp.in"
        "${CMAKE_CURRENT_SOURCE_DIR}/main.cpp.in"
        @ONLY
)
configure_file(
        "${CMAKE_CURRENT_SOURCE_DIR}/Runner.rc.in"
        "${CMAKE_CURRENT_SOURCE_DIR}/Runner.rc.in"
        @ONLY
)

# Define the application target. To change its name, change BINARY_NAME in the
# top-level CMakeLists.txt, not the value here, or `flutter run` will no longer
# work.
#
# Any new source files that you add to the application should be added here.
add_executable(${BINARY_NAME} WIN32
        "flutter_window.cpp"
        "main.cpp.in"
        "utils.cpp"
        "win32_window.cpp"
        "${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc"
        "Runner.rc.in"
        "runner.exe.manifest"
)

# Apply the standard set of build settings. This can be removed for applications
# that need different build settings.
apply_standard_settings(${BINARY_NAME})

# Add preprocessor definitions for the build version.
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION=\"${FLUTTER_VERSION}\"")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MAJOR=${FLUTTER_VERSION_MAJOR}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_MINOR=${FLUTTER_VERSION_MINOR}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_PATCH=${FLUTTER_VERSION_PATCH}")
target_compile_definitions(${BINARY_NAME} PRIVATE "FLUTTER_VERSION_BUILD=${FLUTTER_VERSION_BUILD}")

# Disable Windows macros that collide with C++ standard library functions.
target_compile_definitions(${BINARY_NAME} PRIVATE "NOMINMAX")

# Add dependency libraries and include directories. Add any application-specific
# dependencies here.
target_link_libraries(${BINARY_NAME} PRIVATE flutter flutter_wrapper_app)
target_link_libraries(${BINARY_NAME} PRIVATE "dwmapi.lib")
target_include_directories(${BINARY_NAME} PRIVATE "${CMAKE_SOURCE_DIR}")

# Run the Flutter tool portions of the build. This must not be removed.
add_dependencies(${BINARY_NAME} flutter_assemble)