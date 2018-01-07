###############################################################################
# Diagnostic Options
#
# 981 - warnings about operands evaluated in unspecified order
# 181 - warnings about using an int for a %lu or a long for a %d, etc
# 2259 - warnings about converting uint16_t to uint8_t losing precision
# 2282 - warnings about unrecognized gcc/g++ pragmas
# 10382 - Telling me what option xHost was setting
# 2015 - One of the effective C++ warnings for always using // for comments
# 2012 - Another effective C++ warnings for not using #defines
# 11071 - Warnings about inlines not being honored
###############################################################################
set(BASE_DIAG_OPTIONS
  -w2
  -Wall
  -Wabi
  -Wcheck
  -Winline
  -Wshadow
  -Wremarks
  -Wcomment
  -w2
  -wd181
  -wd981
  -wd2282
  -wd10382
  -g
  )
set(C_DIAG_OPTIONS ${BASE_DIAG_OPTIONS})
set(CXX_DIAG_OPTIONS ${BASE_DIAG_OPTIONS}
  -Weffc++
  -wd2015
  -wd2012
  -wd1082
  -wd11071
  -std=c++11
  )

################################################################################
# Checking Options                                                             #
################################################################################
set(BASE_CHECK_OPTIONS
  -check=conversions,stack,uninit
  -check-pointers=rw
  -check-pointers-dangling=all
  -check-pointers-undimensioned
  )
if (WITH_CHECKS)
  set(C_CHECK_OPTIONS ${BASE_CHECK_OPTIONS})
  set(CXX_CHECK_OPTIONS ${BASE_CHECK_OPTIONS})
endif()

################################################################################
# Optimization Options                                                         #
################################################################################
set(BASE_OPT_OPTIONS
  -O3
  -ipo
  -no-prec-div
  -xHost
  -fp-model
  fast=2
  )

if (ENABLE_OPENMP)
  set(BASE_OPT_OPTIONS ${BASE_OPT_OPTIONS}
    -qopenmp
    -parallel
    -parallel-source-info=2
    )
endif ()

if(GUIDED_OPT)
  set(BASE_OPT_OPTIONS ${BASE_OPT_OPTIONS}
    -guide
    -parallel
    -guide-par
    -guide-vec
    -guide-data-trans
    )
endif()

set(C_OPT_OPTIONS ${BASE_OPT_OPTIONS})
set(CXX_OPT_OPTIONS ${BASE_OPT_OPTIONS})

################################################################################
# Reporting Options                                                            #
################################################################################
set(REPORT_OPTIONS
  -qopt-report-phase=all
  -qopt-report-file=$(REPORTDIR)/opt.rprt
  )
