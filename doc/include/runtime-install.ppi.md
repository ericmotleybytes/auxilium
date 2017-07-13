Runtime installation is relatively easy. As an example, below is
a sample installation of auxilium !exec(sbin/show-release), which
is pretty much the same for other auxilium versions if you simply adjust
the release version number.

1.  Download the runtime distribution. There are at least two ways of doing this:

    a.  Primary download method: Right-click on the "!exec(sbin/show-release)" link
        on this page at <https://ericmotleybytes.github.io/auxilium/> and select
        "save link as...".

    a.  Alternate download method: Use the "wget" program to get the tar file.

        ~~~~~
        $ wget https://github.com/ericmotleybytes/auxilium\
        /releases/download/!exec(sbin/show-release)\
        /auxilium-run-!exec(sbin/show-release).tar.gz
        ~~~~~

        This will create the file "auxilium-run-!exec(sbin/show-release).tar.gz".

1.  Unpack the tar file.

    ~~~~~
    $ tar -xzf auxilium-run-!exec(sbin/show-release).tar.gz
    ~~~~~

    This will create a sub-directory called "auxilium-run-!exec(sbin/show-release)"
    which contains additional files and directories.

1.  Set the default directory to the "auxilium-run-!exec(sbin/show-release)"
    sub-directory.

    ~~~~~
    $ cd auxilium-run-!exec(sbin/show-release)
    ~~~~~

1.  Use make to install auxilium under your desired directory prefix.

    a.  Personal install: To install auxilium under a personal directory,
        for example under the ~/local directory, issue the following command:

        ~~~~~
        $ make install PREFIX=~/local
        ~~~~~

        This installs executable scripts in ~/local/bin, man pages in
        ~/local/man/man1, html files in ~/local/share/html, and so forth.

    a.  System install: To install auxilium under a shared system-wide
        directory, for example under the /usr/local directory, issue
        the following command:

        ~~~~~
        $ sudo make install PREFIX=/usr/local
        ~~~~~

1.  Optionally, although this is highly recommended, setup automatic
    auxilium alias definitions in the appropriate login script.

    a.  Personal setup: Edit your ~/.bashrc file and add the line:

        ~~~~
        source ~/local/bin/auxalias
        ~~~~

    b.  System setup: Edit the /etc/bash/bashrc file and add the line:

        ~~~~
        source /usr/local/bin/auxalias
        ~~~~

Congratulations! You have now installed auxilium!

If your MANPATH is defined resonably you should be able to see an
overview of auxilium by typing:

~~~~~
$ man auxilium
~~~~~
