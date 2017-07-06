This "test/temp" directory is for temporary files some unit test scripts use.
Bats has a separate facility for temporary files, but for debugging sometimes
more explicit control of temp files is nice.

All files in this temp directory except for this 'aaareadme.txt' (this file)
and the '.gitignore' file should be considered temporary. Temporary file
should generally not be put under git source code control and should be
safe to delete at any time that unit tests are not running.

To make it easier to cleanup temp files in this directory (and avoid
accidentally deleting a non-temporary file) unit test script writers
are encourages to make temporary subdirectories in this directory that
are easier to clean up.
