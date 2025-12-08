cmake_minimum_required(VERSION 3.16)
project(retropad C RC)

# Set C standard
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Source files
set(SOURCES
    retropad.c
    file_io.c
)

# Header files
set(HEADERS
    file_io.h
    resource.h
)

# Resource file
set(RESOURCES
    retropad.rc
)

# Create executable
add_executable(retropad WIN32 ${SOURCES} ${HEADERS} ${RESOURCES})

# Link libraries
target_link_libraries(retropad
    user32
    gdi32
    comdlg32
    comctl32
    shell32
)

# Add include directories
target_include_directories(retropad PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

# Set Unicode and Windows defines
target_compile_definitions(retropad PRIVATE
    UNICODE
    _UNICODE
    WIN32
    _WINDOWS
)

# Compiler-specific settings for MSVC
if(MSVC)
    target_compile_options(retropad PRIVATE /W4)
    set_target_properties(retropad PROPERTIES
        VS_DEBUGGER_WORKING_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
    )
endif()
