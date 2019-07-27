#!/bin/sh -e

SHELL=/bin/sh
INSTALL=/usr/bin/install
PREFIX="$PWD"/build
MANDIR="$PREFIX"/share/man
BINDIR="$PREFIX"/bin
LIBDIR="$PREFIX"/lib

# to be overriden by user
CFLAGS=
LDFLAGS=

mkdir -p "$PREFIX"

do_make() {
    # heirloom uses a lot of old style obnoxious variables
    # rather than patching every makefile, just declare them inline.
    # we want all the files to end up in the same directories.
    make CFLAGS="-static --static $CFLAGS" LDFLAGS="-static --static $LDFLAGS" \
         SHELL="$SHELL" POSIX_SHELL="$SHELL" INSTALL="$INSTALL" \
         PREFIX="$PREFIX"  MANDIR="$MANDIR"  BINDIR="$BINDIR" \
         SUSBIN="$BINDIR" $1
}
build() {
    cd "$1"
    do_make "$2"
    cd ..
}

case "$1" in
    *help|-h)
cat << EOF
usage:
--------
provide no arguments to build
'./build.sh install' to install
EOF
        exit
        ;;
    install)
        $INSTALL -Dm0755 one-true-awk/a.out "$PREFIX"/bin/awk
        $INSTALL -Dm0644 one-true-awk/awk.1 "$PREFIX"/share/man/man1/awk.1

        # heirloom-devtools
        build heirloom-devtools install

        # heirloom's makefile is a mess. just do this manually.
        find heirloom -type d ! -name build ! -name libcommon \
                ! -name libuxre | while read -r dir ; do
            $INSTALL -Dm0755 heirloom/$dir/$dir "$PREFIX"/bin/$dir
            $INSTALL -Dm0644 heirloom/$dir/$dir.1 "$PREFIX"/share/man/man1/$dir.1
        done
        $INSTALL -Dm0644 heirloom/file/magic "$PREFIX"/etc/magic
        ln -s pgrep "$PREFIX"/bin/pkill
        ;;
    *) 
        build heirloom-devtools
        build heirloom
        build one-true-awk
esac
