cmake_minimum_required(VERSION 3.12)
project(test-lief-spdlog)

find_package(LIEF CONFIG REQUIRED COMPONENTS SHARED)
find_package(spdlog CONFIG REQUIRED)

add_executable(test-lief-spdlog test-lief-spdlog.cpp)
target_link_libraries(test-lief-spdlog PRIVATE LIEF::LIEF spdlog::spdlog)
