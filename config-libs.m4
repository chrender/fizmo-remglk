
remglk_nonpkg_cflags=""
remglk_nonpkg_libs=""

AC_CHECK_HEADER([glk.h],
  [],
  [for dir in $with_glk_includedir /usr/include /usr/local/include /usr/include/remglk /usr/local/include/remglk ; do
     AC_MSG_CHECKING(for glk.h in $dir)
     if [ test -e $dir/glk.h ]; then
       AC_MSG_RESULT(yes)
       remglk_h_dir=$dir
       break
     else
       AC_MSG_RESULT(no)
     fi
   done
   if [ test "x$remglk_h_dir" == "x"] ; then
     echo "Could not find glk.h."
     echo "Try setting the location using --with-remglk-includedir."
     AS_EXIT
   fi
   remglk_nonpkg_cflags+=" -I$remglk_h_dir"])

AC_CHECK_LIB([remglk],
  [main],
  [],
  [LIBS_OLD=$LIBS
   LIBS="-lremglk"
   for dir in $with_remglk_libdir /usr/lib /usr/local/lib ; do
     AC_MSG_CHECKING(for libremglk in $dir)
     LDFLAGS="-L$dir"
     AC_LINK_IFELSE(
       [AC_LANG_SOURCE(
        [[
          #include <stdio.h>
          #include "$remglk_h_dir/glk.h"
          #include "$remglk_h_dir/glkstart.h"
          glkunix_argumentlist_t glkunix_arguments[] = { };
          int glkunix_startup_code(glkunix_startup_t *data) { }
          void glk_main(void) { glk_exit(); } ]])],
       [AC_MSG_RESULT(yes)
        remglk_l_dir=$dir
        break],
       [AC_MSG_RESULT(no)])
   done
   if [ test "x$remglk_l_dir" == "x"] ; then
     echo "Could not find libremglk."
     echo "Try setting the location using --with-remglk-libdir."
     AC_MSG_ERROR([Could not find libremglk.])
     AC_MSG_ERROR([You need to specify libremglk.a location using "--with-remglk-libdir=<path>".])
     AS_EXIT
   fi
   LIBS=$LIBS_OLD
   remglk_nonpkg_libs+=" -L$remglk_l_dir -lremglk"
])

