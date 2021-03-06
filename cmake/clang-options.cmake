################################################################################
# Debugging Options                                                            #
################################################################################
set(LIBRA_DEBUG_OPTIONS "-g2")

################################################################################
# Optimization Options                                                         #
################################################################################
if ("${CMAKE_BUILD_TYPE}" STREQUAL "DEV")
  set(LIBRA_OPT_LEVEL -O0)
elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "DEVOPT")
  set(LIBRA_OPT_LEVEL -Og)
elseif ("${CMAKE_BUILD_TYPE}" STREQUAL "OPT")
  set(LIBRA_OPT_LEVEL -O2)
endif()

set(BASE_OPT_OPTIONS
  -Ofast
  -march=native
  -mtune=native
  -fno-stack-protector
  -flto
  -ffast-math
  -fno-unsafe-math-optimizations
  -Werror
  )

if (LIBRA_OPENMP)
  set(BASE_OPT_OPTIONS ${BASE_OPT_OPTIONS}
    -fopenmp
    )
endif()

set(LIBRA_C_OPT_OPTIONS ${BASE_OPT_OPTIONS})
set(LIBRA_CXX_OPT_OPTIONS ${BASE_OPT_OPTIONS})

if ("${CMAKE_BUILD_TYPE}" STREQUAL "OPT")
  # For handling lto with static libraries on MSI
  set(CMAKE_AR "llvm-ar")
  set(CMAKE_NM "llvm-nm")
  set(CMAKE_RANLIB "llvm-ranlib")
  set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -flto")
endif()

################################################################################
# Diagnostic Options                                                           #
################################################################################
set(BASE_DIAG_OPTIONS
  -Weverything
  -fdiagnostics-color=always
  -Wno-reserved-id-macro
  -Wno-padded
  -Wno-packed
  -Wno-gnu-zero-variadic-macro-arguments
  -Wno-language-extension-token
  -Wno-gnu-statement-expression
  -Wshorten-64-to-32
  -Wno-cast-align
  -Wno-weak-vtables
  -Wno-documentation
  -Wno-extra-semi-stmt
  -Wno-extra-semi
  -fcomment-block-commands=internal,endinternal
  )

if (LIBRA_OPENMP)
  set(BASE_DIAG_OPTIONS "${BASE_DIAG_OPTIONS}"
    -fopenmp
    )
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -fopenmp")
endif()

set(LIBRA_C_DIAG_OPTIONS ${BASE_DIAG_OPTIONS})
set(LIBRA_CXX_DIAG_OPTIONS ${BASE_DIAG_OPTIONS}
  -fdiagnostics-show-template-tree
  -Wno-c++98-compat
  -Wno-c++98-compat-pedantic
  -Weffc++
  -Wno-c99-extensions
  )


################################################################################
# Checking Options                                                             #
################################################################################
set(MSAN_OPTIONS
  -fno-omit-frame-pointer
  -fno-optimize-sibling-calls
  -fsanitize=memory,leak
  -fsanitize-memory-track-origins
  )
set(ASAN_OPTIONS
  -fno-omit-frame-pointer
  -fno-optimize-sibling-calls
  -fsanitize=address
  )
set(SSAN_OPTIONS
  -fno-omit-frame-pointer
  -fstack-protector-all
  -fstack-protector-strong
  )
set(UBSAN_OPTIONS
  -fno-omit-frame-pointer
  -fsanitize=undefined
  -fsanitize=float-divide-by-zero
  -fsanitize=unsigned-integer-overflow
  -fsanitize=local-bounds
  -fsanitize=nullability
  )
set(TSAN_OPTIONS
  -fno-omit-frame-pointer
  -fsanitize=thread
  )

set(BASE_SAN_OPTIONS)
if ("${LIBRA_SAN}" MATCHES "MSAN")
  set(BASE_SAN_OPTIONS "${BASE_SAN_OPTIONS} ${MSAN_OPTIONS}")
endif()

if ("${LIBRA_SAN}" MATCHES "ASAN")
  set(BASE_SAN_OPTIONS "${BASE_SAN_OPTIONS} ${ASAN_OPTIONS}")
endif()

if ("${LIBRA_SAN}" MATCHES "SSAN")
  set(BASE_SAN_OPTIONS "${BASE_SAN_OPTIONS} ${SSAN_OPTIONS}")
endif()

if ("${LIBRA_SAN}" MATCHES "UBSAN")
  set(BASE_SAN_OPTIONS "${BASE_SAN_OPTIONS} ${UBSAN_OPTIONS}")
endif()

if ("${LIBRA_SAN}" MATCHES "TSAN")
  set(BASE_SAN_OPTIONS "${BASE_SAN_OPTIONS} ${TSAN_OPTIONS}")
endif()

set(LIBRA_C_SAN_OPTIONS ${BASE_SAN_OPTIONS})
set(LIBRA_CXX_SAN_OPTIONS ${BASE_SAN_OPTIONS})

################################################################################
# Profiling Options                                                            #
################################################################################
set(BASE_PGO_GEN_OPTIONS
  -fprofile-generate
  )
set(BASE_PGO_USE_OPTIONS
  -fprofile-use
  )

if (LIBRA_PGO_GEN)
  set(LIBRA_C_PGO_GEN_OPTIONS ${BASE_PGO_GEN_OPTIONS})
  set(LIBRA_CXX_PGO_GEN_OPTIONS ${BASE_PGO_GEN_OPTIONS})
endif()

if (LIBRA_PGO_USE)
  set(LIBRA_C_PGO_USE_OPTIONS ${BASE_PGO_USE_OPTIONS})
  set(LIBRA_CXX_PGO_USE_OPTIONS ${BASE_PGO_USE_OPTIONS})
endif()

################################################################################
# Code Coverage Options                                                        #
################################################################################
set(BASE_CODE_COV_OPTIONS
  -fprofile-instr-generate
  -fcoverage-mapping
  )

if (LIBRA_CODE_COV)
  set(LIBRA_C_CODE_COV_OPTIONS ${BASE_CODE_COV_OPTIONS})
  set(LIBRA_CXX_CODE_COV_OPTIONS ${BASE_CODE_COV_OPTIONS})
endif()
