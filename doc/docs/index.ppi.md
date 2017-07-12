## Auxilium Introduction

This is the Auxilium information and download page.

!include(../include/auxilium-introduction.ppi.md)

## Auxilium Released Downloads

!exec(sbin/show-rels-html)

## Auxilium Prerequisites

All version of auxilium require bash version 4.2 or higher.

## Auxilium Runtime Install

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
        wget https://github.com/ericmotleybytes/auxilium/releases/download/!exec(sbin/show-release)/auxilium-run-!exec(sbin/show-release).tar.gz
        ~~~~~

        This will create the file "auxilium-run-!exec(sbin/show-release).tar.gz".

1.  Unpack the tar file.

    ~~~~~
    tar -xzf auxilium-run-!exec(sbin/show-release).tar.gz
    ~~~~~

    This will create a sub-directory called "auxilium-run-!exec(sbin/show-release)"
    which contains additional files and directories.

1.  Set the default directory to the "auxilium-run-!exec(sbin/show-release)"
    sub-directory.

    ~~~~~
    cd auxilium-run-!exec(sbin/show-release)
    ~~~~~

1.  Use make to install auxilium under your desired directory prefix.

    a.  Personal install: To install auxilium under a personal directory,
        for example under the ~/local directory, issue the following command:

        ~~~~~
        make install PREFIX=~/local
        ~~~~~

        This installs executable scripts in ~/local/bin, man pages in
        ~/local/man/man1, html files in ~/local/share/html, and so forth.

    a.  System install: To install auxilium under a shared system-wide
        directory, for example under the /usr/local directory, issue
        the following command:

        ~~~~~
        sudo make install PREFIX=/usr/local
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
man auxilium
~~~~~

## Additional Documentation

Version specific auxilium manuals are installed in
the \<PREFIX\>/share/html/auxilium directory.
The auxilium user guide is available in that directory
in both HTML format (auxilium-user-guide.html)
and pdf format (auxilium-user-guide.pdf).

For convenience the latest version of the user guide is also
available online in both HTML and PDF formats:

* [https://ericmotleybytes.github.io/auxilium/auxilium-user-guide.html](Auxilium User Guide (html))
* [https://ericmotleybytes.github.io/auxilium/auxilium-user-guide.pdf](Auxilium User Guide (pdf))

## Auxilium Runtime Uninstall

You can also easily uninstall auxilium.
As an example, below is a sample uninstall of
auxilium !exec(sbin/show-release), which
is pretty much the same for other auxilium versions if you simply adjust
the release version number.

1.  Set the default directory to the "auxilium-run-!exec(sbin/show-release)"
    sub-directory.

    ~~~~~
    cd auxilium-run-!exec(sbin/show-release)
    ~~~~~

1.  Use make to uninstall auxilium under your desired directory prefix.

    a.  Personal uninstall: To uninstall auxilium from under a personal directory
        where it was previously installed,
        for example under the ~/local directory, issue the following command:

        ~~~~~
        make install PREFIX=~/local
        ~~~~~

        This remove only auxilium installed files.

    a.  System install: To uninstall auxilium under a shared system-wide
        directory where it was previously installed,
        for example under the /usr/local directory, issue
        the following command:

        ~~~~~
        sudo make uninstall PREFIX=/usr/local
        ~~~~~

1.  Optionally, if you edited a login script during installation,
    your might want to delete or comment out the line you added.

    a.  Personal setup: Edit your ~/.bashrc file and remove or
        comment the line:

        ~~~~
        source ~/local/bin/auxalias
        ~~~~

        If commented, the line will then look like:

        ~~~~
        #source ~/local/bin/auxalias
        ~~~~

    b.  System setup: Edit the /etc/bash/bashrc file and remove or comment
        the line:

        ~~~~
        source /usr/local/bin/auxalias
        ~~~~

        If commented, the line will then look like:

        ~~~~
        #source /usr/local/bin/auxalias
        ~~~~

1.  Set the default directory to the original download directory and
    delete the tar distribution file and the unpacked files.

    ~~~~~
    cd <download-directory>
    rm auxilium-run-!exec(sbin/show-release).tar.gz
    rm -rf auxilium-run-!exec(sbin/show-release)
    ~~~~~

You have now uninstalled auxilium.

## See Also

* <https://github.com/ericmotleybytes/auxilium> : The master auxilium
  GitHub repository. You can also report bugs, describe issues, and
  request enhancements here.

* <https://github.com/ericmotleybytes/auxilium> : The master GitHub repository
  page for Auxilium.

* <https://testanything.org/> : A description of TAP,
  the unit testing Test Anything protocol.
