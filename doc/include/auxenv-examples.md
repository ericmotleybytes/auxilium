Here are some examples of using auxenv.

* Displaying a pathlike environment variable:

        $ export DEMOPATH="/dir1:/dir2:/dir3"
        $ auxenv show DEMOPATH
        DEMOPATH is set to:
        /dir1:/dir2:/dir3
        Item breakdown:
          1=/dir1
          2=/dir2
          3=/dir3
        $ auxenv dump DEMOPATH
        /dir1
        /dir2
        /dir3

* Prepending a directory:

        $ export DEMOPATH="/dir1:/dir2:/dir3"
        $ auxenv prepend DEMOPATH /dir0
        $ echo "$DEMOPATH"
        /dir0:/dir1:/dir2:/dir3

* Inserting a directory:

        $ export DEMOPATH="/dir1:/dir2:/dir3"
        $ auxenv insert DEMOPATH "/dir1a" before "/dir2"
        $ echo "$DEMOPATH"
        /dir1:/dir1a:/dir2:/dir3

* Erasing a directory by name:

        $ export DEMOPATH="/dir1:/dir2:/dir3"
        $ auxenv erase DEMOPATH "/dir2"
        $ echo "$DEMOPATH"
        /dir1:/dir3

* Erasing a directory by position:

        $ export DEMOPATH="/dir1:/dir2:/dir3"
        $ auxenv erase DEMOPATH @2
        $ echo "$DEMOPATH"
        /dir1:/dir3

* Working with alternate separators:

        $ export DEMOPATH="red|green|blue"
        $ auxenv show DEMOPATH
        DEMOPATH is set to:
        red|green|blue
        Item breakdown:
          1=red
          2=green
          3=blue
