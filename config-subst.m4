
# This is included from fizmo-dist and not required by fizmo-remglk's own
# configuration. It nevertheless needs to be maintained so fizmo-dist
# will still work.
#
# The $build_prefix, $build_prefix_cflags and $build_prefix_libs are
# pre-defined by fizmo-dist.

AC_SUBST([REMGLK_NONPKG_CFLAGS], "$remglk_nonpkg_cflags")
AC_SUBST([REMGLK_NONPKG_LIBS], "$remglk_nonpkg_libs")

