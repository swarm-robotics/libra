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
  -ffinite-math-only
  -frename-registers
  -Werror
  )

if (LIBRA_OPENMP)
  set(BASE_OPT_OPTIONS ${BASE_OPT_OPTIONS}
    -fopenmp
    )
endif()

set(LIBRA_C_OPT_OPTIONS)
set(LIBRA_CXX_OPT_OPTIONS)

if ("${CMAKE_BUILD_TYPE}" STREQUAL "OPT")
  set(CMAKE_AR "llvm-ar")
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
set(BASE_CHECK_OPTIONS
  -fno-omit-frame-pointer
  )
set(MEM_CHECK_OPTIONS
  -fsanitize=memory
  -fsanitize-memory-track-origins
  -fsanitize-memory-use-after-dtor
  )
set(ADDR_CHECK_OPTIONS
  -fsanitize=address,leak
  )
set(STACK_CHECK_OPTIONS
  -fstack-protector-all
  -fstack-protector-strong
  )
set(MISC_CHECK_OPTIONS
  -fsanitize=undefined
  )

if ("${LIBRA_CHECKS}" MATCHES "MEM")
  set(LIBRA_C_CHECK_OPTIONS ${BASE_CHECK_OPTIONS} ${MEM_CHECK_OPTIONS})
  set(LIBRA_CXX_CHECK_OPTIONS ${BASE_CHECK_OPTIONS} ${MEM_CHECK_OPTIONS})
endif()
if ("${LIBRA_CHECKS}" MATCHES "ADDR")
  set(LIBRA_C_CHECK_OPTIONS ${BASE_CHECK_OPTIONS} ${ADDR_CHECK_OPTIONS})
  set(LIBRA_CXX_CHECK_OPTIONS ${BASE_CHECK_OPTIONS} ${ADDR_CHECK_OPTIONS})
endif()
if ("${LIBRA_CHECKS}" MATCHES "STACK")
  set(LIBRA_C_CHECK_OPTIONS ${BASE_CHECK_OPTIONS} ${STACK_CHECK_OPTIONS})
  set(LIBRA_CXX_CHECK_OPTIONS ${BASE_CHECK_OPTIONS} ${STACK_CHECK_OPTIONS})
endif()
if ("${LIBRA_CHECKS}" MATCHES "MISC")
  set(LIBRA_C_CHECK_OPTIONS ${BASE_CHECK_OPTIONS} ${MISC_CHECK_OPTIONS})
  set(LIBRA_CXX_CHECK_OPTIONS ${BASE_CHECK_OPTIONS} ${MISC_CHECK_OPTIONS})
endif()


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
