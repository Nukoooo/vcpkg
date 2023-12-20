vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO Nukoooo/socket.io-client-cpp
    REF 2ea989d934821228f8ffeb9515978290ddf35c08
    SHA512 121ea9513d0530ae02c0fca0dd44da771ea8f4ad213b6c3c4af6d331ed922cc593e340ca6a7c5961160adf8c47783fe5d4127151511e6444f280327f80a07d40
    HEAD_REF fix-build
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DUSE_SUBMODULES=OFF
        -DCMAKE_INSTALL_INCLUDEDIR=include
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME sioclient CONFIG_PATH lib/cmake/sioclient)
vcpkg_replace_string("${CURRENT_PACKAGES_DIR}/share/sioclient/sioclientConfig.cmake"
    "include(CMakeFindDependencyMacro)"
    [[include(CMakeFindDependencyMacro)
find_dependency(websocketpp CONFIG)
find_dependency(asio CONFIG)
find_dependency(RapidJSON CONFIG)
find_dependency(OpenSSL)]])

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
