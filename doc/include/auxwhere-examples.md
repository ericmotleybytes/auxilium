Here are some examples of using auxwhere.

* Finding the first instance of a file somewhere in a PATH directory:

        $ auxwhere myfile
        /some/directory/myfile

* Finding all instances of a file somewhere in a PATH directory:

        $ auxwhere --all myfile
        /some/directory/myfile
        /some/other/directory/myfile
        /another/directory/myfile

* Finding the first instance of a file somewhere in a LD_LIBRARY_PATH directory.

        $ auxwhere --env=LD_LIBRARY_PATH libproxy.so.1
        /usr/lib64/libproxy.so.1

* Finding a file and seeing how the file was found using two path-like environment variables.

        $ auxwhere --all --env=PRIMARYPATH --env=SECONDARYPATH myfile.bash
        /some/directory/myfile.bash	   (Found via PRIMARYPATH)
        /another/directory/myfile.bash	   (Found via SECONDARYPATH)

* Finding a file searching multiple file types and a sub-directory.

        $ auxwhere --env=MANPATH --subdir=.man --type=.1 --type=.1.gz awk
        /usr/share/man/man1/awk.1.gz
