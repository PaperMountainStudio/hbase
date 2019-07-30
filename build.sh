#!/bin/sh -e

: "${PREFIX:="$PWD/build"}"
: "${SHELL:=/bin/sh}"
: "${CC:=gcc}"
: "${INSTALL:=/usr/bin/install}"
: "${YACC:=yacc}"
: "${CFLAGS:="-0s -s"}"
: "${LDFLAGS:=-s}"
: "${MANDIR:="$PREFIX/share/man"}"
: "${BINDIR:="$PREFIX/bin"}"
: "${LIBDIR:="$PREFIX/lib"}"

mkdir -p "$PREFIX"

do_make() {
    # heirloom uses a lot of old style obnoxious variables
    # rather than patching every makefile, just declare them inline.
    # we want all the files to end up in the same directories.
    make CFLAGS="-static --static $CFLAGS" CFLAGSS="-static --static $CFLAGS" \
         LDFLAGS="-static --static $LDFLAGS" CC="$CC" cc="$CC" SHELL="$SHELL" \
         POSIX_SHELL="$SHELL" YACC="$YACC" INSTALL="$INSTALL" \
         PREFIX="$PREFIX"  MANDIR="$MANDIR"  \
         BINDIR="$BINDIR" SUSBIN="$BINDIR" SU3BIN="$BINDIR" UCBBIN="$BINDIR" \
         DEFLIB="$LIBDIR" DEFBIN="$BINDIR" MAGIC="/lib/magic" \
         DEFSBIN="$BINDIR" SV3BIN="$BINDIR" $1
}
build() {
    cd "$1"
    do_make "$2"
    cd ..
}
patchall() {
    find patches -type f | while read -r patch ; do
        patch -p0 < "$patch"
    done
}

case "$1" in
    *help|-h)
cat << EOF
usage:
--------
provide no arguments to build
'./build.sh install' to install

Make will read variables from the environment,
to add environment flags for just one command
prefix it with the variables to set.
Example:
PREFIX=/path/to/build CFLAGS='-O2 -pipe' ./build.sh
EOF
        exit
        ;;
    install)
        $INSTALL -Dm0755 one-true-awk/a.out "$PREFIX"/bin/awk
        $INSTALL -Dm0644 one-true-awk/awk.1 "$PREFIX"/share/man/man1/awk.1

        # heirloom-devtools
        build heirloom-devtools install

        # heirloom's makefile is a mess. just do this manually.
        for dir in bc cpio dc diff file fmt pgrep stty ; do
            $INSTALL -Dm0755 heirloom/$dir/$dir "$PREFIX"/bin/$dir
            $INSTALL -Dm0644 heirloom/$dir/$dir.1 "$PREFIX"/share/man/man1/$dir.1
        done
        $INSTALL -Dm0644 heirloom/file/magic "$PREFIX"/lib/magic
        ln -sf pgrep "$PREFIX"/bin/pkill
        ;;
    *) 
        patchall
        build heirloom-devtools
        build heirloom
        build one-true-awk
esac
