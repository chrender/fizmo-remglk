
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
   remglk_nonpkg_cflags+=" -I$remglk_h_dir"

   CFLAGS_SAVED=$CFLAGS
   LIBS_SAVED=$LIBS
   LDFLAGS_SAVED=$LDFLAGS
   LIBS="-lremglk"
   for dir in $with_remglk_libdir /usr/lib /usr/local/lib ; do
     AC_MSG_CHECKING(for libremglk in $dir)
     LDFLAGS="-L$dir"
     AC_TRY_LINK(
       [#include <stdio.h>
        #include "$remglk_h_dir/glk.h"
        #include "$remglk_h_dir/glkstart.h"],
       [glkunix_argumentlist_t glkunix_arguments[] = { };
        int glkunix_startup_code(glkunix_startup_t *data) { }
        void glk_main(void) { glk_exit(); } ],
       [AC_MSG_RESULT(yes)
        remglk_l_dir=$dir
        break],
       [AC_MSG_RESULT(no)])
   done
   if [ test "x$remglk_l_dir" == "x"] ; then
     echo "Could not find libremglk."
     echo "Try setting the location using --with-remglk-libdir."
     exit
   fi
   LIBS=$LIBS_SAVED
   LDFLAGS=$LDFLAGS_SAVED
   CFLAGS=$CFLAGS_SAVED
   remglk_nonpkg_libs="-L$remglk_h_dir -lremglk"
   libremglk_LIBS="-L$remglk_l_dir -lremglk"])

