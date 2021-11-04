#! /bin/bash
set -x
find | grep "\.c$\|\.h$" > cscope.files
cscope -Rbq
ctags -L cscope.files
