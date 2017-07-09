Note that the !AUXCMD "command" is not actually an "executable" script or binary image.
Rather it is a "sourceable" script, meaning it is designed to run when invoked by the
bash "source" built-in command. However, by using the bash built-in "alias" command,
we can define an alias for !AUXCMD such that it mimicks the usage behavior of an actual
executable program. For example, consider the alias definition:

    alias !AUXCMD="source /usr/local/bin/!AUXCMD"

Once this alias is defined, interactive users and other scripts can invoke (source)
the !AUXCMD script simply by specifying "!AUXCMD" followed by any desired additional
!AUXCMD parameters. (Assuming !AUXCMD was installed in /usr/local/bin.) If auxilium
was installed system-wide by your system administrator it is quite likely this alias
will already be defined for you (probably in the /etc/bashrc file). You can type "alias"
to see a list of all currently defined aliases. If this alias is not defined, you
can add the alias definition in your personal \$(HOME)/.bashrc file. Note that your
aliases should be defined in \$(HOME)/.bashrc file, not \$(HOME)/.bash_profile.

Sourceable scripts are needed if the current process environment is to be modified,
rather than a subprocess environment that executable programs always run in. Since
!AUXCMD potentially needs to modify the current process environment, it needs to be
a sourceable script.
