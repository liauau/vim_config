This is a backup of the origin repo and complement with my own configuration for vim.

The origin README is here: [README](./ORIGIN_README.md)

# How to set up ctags and cscope
   1. install ctags and cscope. run command: `sudo apt install ctags cscope -y`
   2. put the shell scipt with name like `gen_tag_files_and_db.sh` into somewhere in your PATH,
   like `/usr/local/bin`. The content of the scipt is as follows:
   ```
    #! /bin/bash
    set -x
    find | grep "\.c$\|\.h$" > cscope.files
    cscope -Rbq
    ctags -L cscope.files

   ```
   3. cd the code src dir and run scipt `gen_tag_files_and_db.sh` and it will generate 5 files,
      including `cscope.in.out` `cscope.po.out` `cscope.out` `cscope.files` `tags`
   4. run `vim` at the code src dir. The ctags and cscope would work well.

# Tips
  If the dependency libs of the project are very large, it would slow down the search speed of vim.
  You can move the dependency libs out of the project and make a soft link to the root directory 
  of the lib to make compiling successful, and the vim would be faster since it does not search the
  libs anymore.
