#!/bin/bash

set -xeuo pipefail

LIEF_MBEDTLS_EXTERNAL=ON
if [[ "${target_platform:-}" == "linux-riscv64" ]]; then
  # LIEF 1.0.0 requires exactly MbedTLS 4.0.0, which is not published for
  # linux-riscv64. Its source archive contains the supported 4.0.0 sources.
  LIEF_MBEDTLS_EXTERNAL=OFF
fi

CMAKE_ARGS="${CMAKE_ARGS} \
  -DBUILD_STATIC_LIBS=OFF \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_SKIP_RPATH=ON \
  -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=ON \
  -DLIEF_EXAMPLES=OFF \
  -DLIEF_EXTERNAL_SPDLOG=ON \
  -DLIEF_OPT_NLOHMANN_JSON_EXTERNAL=ON \
  -DLIEF_OPT_MBEDTLS_EXTERNAL=${LIEF_MBEDTLS_EXTERNAL} \
  -DLIEF_PY_LIEF_EXT=OFF \
  -DLIEF_PY_LIEF_EXT_SHARED=ON \
  -DLIEF_PYTHON_API=OFF \
"

# Please keep this comment around. It may help if this problem reoccurs.
# if [[ ${target_platform} =~ linux-* ]]; then
#   # export LDFLAGS="${LDFLAGS} -Wl,--trace -Wl,--cref -Wl,--trace-symbol,_ZTIN4LIEF5MachO16BuildToolVersionE"
#   # export LDFLAGS="${LDFLAGS} -Wl,--trace-symbol,_ZTIN4LIEF5MachO16BuildToolVersionE -Wl,--trace-symbol,_ZTIN4LIEF5MachO12BuildVersionE"
# fi

mkdir -p build

cmake ${CMAKE_ARGS} -LAH -G "Ninja" -B build
