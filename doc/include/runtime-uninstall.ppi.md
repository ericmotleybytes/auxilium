You can also easily uninstall auxilium.
As an example, below is a sample uninstall of
auxilium !exec(sbin/show-release), which
is pretty much the same for other auxilium versions if you simply adjust
the release version number.

1.  Set the default directory to the "auxilium-run-!exec(sbin/show-release)"
    sub-directory.

    ~~~~~
    $ cd auxilium-run-!exec(sbin/show-release)
    ~~~~~

1.  Use make to uninstall auxilium under your desired directory prefix.

    a.  Personal uninstall: To uninstall auxilium from under a personal directory
        where it was previously installed,
        for example under the ~/local directory, issue the following command:

        ~~~~~
        $ make install PREFIX=~/local
        ~~~~~

        This remove only auxilium installed files.

    a.  System install: To uninstall auxilium under a shared system-wide
        directory where it was previously installed,
        for example under the /usr/local directory, issue
        the following command:

        ~~~~~
        $ sudo make uninstall PREFIX=/usr/local
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
    $ cd <download-directory>
    $ rm auxilium-run-!exec(sbin/show-release).tar.gz
    $ rm -rf auxilium-run-!exec(sbin/show-release)
    ~~~~~

You have now uninstalled auxilium.
