# https://dev.to/jasny/developing-a-php-extension-in-clion-3oo1

cmake_minimum_required(VERSION 3.26)
project(php_shoco C)

set(CMAKE_C_STANDARD 99)

set(SOURCE_FILES
    php_shoco.c
    shoco/shoco.c
)

add_compile_definitions(HAVE_CONFIG_H=1)

execute_process (
        COMMAND php-config --include-dir
        OUTPUT_VARIABLE PHP_SOURCE
)
string(REGEX REPLACE "\n$" "" PHP_SOURCE "${PHP_SOURCE}")

message("Using source directory: ${PHP_SOURCE}")

include_directories(${PHP_SOURCE})
include_directories(${PHP_SOURCE}/main)
include_directories(${PHP_SOURCE}/Zend)
include_directories(${PHP_SOURCE}/TSRM)
include_directories(${PROJECT_SOURCE_DIR})
include_directories(${PROJECT_SOURCE_DIR}/.direnv/include)

add_custom_target(configure
        COMMAND phpize && ./configure
        DEPENDS ${SOURCE_FILES}
        WORKING_DIRECTORY ${PROJECT_SOURCE_DIR})

add_library(___ EXCLUDE_FROM_ALL ${SOURCE_FILES})
