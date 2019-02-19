
AC_ARG_WITH([remglk-includedir],
  [AS_HELP_STRING([--with-remglk-includedir],
          [Specify include directory to use for remglk])],
  [AC_SUBST([with_remglk_includedir],
    [$( echo $(cd $(dirname "$with_remglk_includedir") && pwd -P)/$(basename "$with_remglk_includedir") )])],
  [with_remglk_includedir=])

AC_ARG_WITH([remglk-libdir],
  [AS_HELP_STRING([--with-remglk-libdir],
          [Specify library directory for remglk])],
  [AC_SUBST([with_remglk_libdir],
    [$( echo $(cd $(dirname "$with_remglk_libdir") && pwd -P)/$(basename "$with_remglk_libdir") )])],
  [with_remglk_libdir=])

