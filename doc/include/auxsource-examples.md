Here are some examples of using auxsource.

* Sourcing a file somewhere in a PATH directory:

        $ auxsource myfile

* Sourcing a file somewhere in a PATH directory and passing some parameters:

        $ auxsource myfile say "hello world"

* Sourcing a file specified by absolute location and passing parameters:

        $ auxsource /home/alice/mything.bash "more" "parameters"

* Sourcing a file somewhere in a MYPATH directory:

        $ export MYPATH="/home/alice:/home/bob"
        $ export AUXSOURCE_OPTIONS="--env=MYPATH"
        $ auxsource myfile "some" "more parameters"
