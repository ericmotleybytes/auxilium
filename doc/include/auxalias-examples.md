Here are some examples of using auxalias.

* Setting up static auxilium aliases to installation in /usr/local:

        $ source /usr/local/bin/auxalias
        $ alias auxenv
        alias auxenv='source /usr/local/bin/auxenv'

* Setting up dynamic auxilium aliases which use PATH:

        $ source /usr/local/bin/auxalias
        $ alias auxenv
        alias auxenv='eval source $(auxwhere auxenv)'
