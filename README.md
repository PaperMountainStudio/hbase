# hbase

Originally started by the [Morpheus Linux](http://git.2f30.org/hbase/log.html) project,
`hbase` is a collection of programs that complement [sbase](http://core.suckless.org/sbase) and [ubase](http://core.suckless.org/ubase).

As Morpheus has since 2014 been abandoned, I am continuing the 
project to be used in my upcoming Linux distribution, [bonsai](http://github.com/mitchweaver/bonsai).

`hbase` contains programs taken from [The Heirloom Project](http://heirloom.sourceforge.net) 
but as well `awk` from [one-true-awk](http://github.com/onetrueawk/awk).

Patches are applied to cleanly compile under [musl-libc](http://musl-libc.org).

------

### What is included?

from **heirloom:**
* bc
* col
* cpio
* csplit
* dc
* diff
* file
* fmt
* pgrep
* stty

from **heirloom-devtools**:
* lex
* yacc
* m4

from **one-true-awk**:
* awk

As `sbase` and `ubase` continue to be developed, this list of programs 
will continue to shrink as they are replaced.

----

### What is NOT included?

Removed from Heirloom is anything that is already included between `sbase` and `ubase`,
as well as tools that are either deemed no longer used in the modern day or
conflict with the suckless ideology of `sbase` and `ubase`.

Some programs which you ***might*** still want:
* banner
* bdiff
* diff3
* dircmp
* factor
* groups *(redundant, /etc/group)*
* getopt
* hd
* id
* mail
* man *(bash/ksh only)*
* more *(just use less)*
* news
* pax
* sdiff
* sum
* tabs
* ul
* what

If you wish to add these, copy the programs dir from the [Heirloom Project](http://github.com/eunuchs/heirloom-project)
repo and edit the the subdir's makefile to include it.

If you believe something should not be excluded from hbase, open
a git issue with your reasoning and I will consider it.

----

### Licensing

Each program is licensed as it is stated in its `LICENSE` directory.  
Licenses have not been changed from their upstream counterparts.  
This repository is simply a repackaging. Sources have not been changed 
unless otherwise stated.
