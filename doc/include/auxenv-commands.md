append \<envvar\> \<item-or-dir\>

:   Modifies the value of the environment variable so that the item (usually a directory) is
    placed as the very last item of the new environment variable value.

clean \<envvar\>

:   This is a convenient way to do commands "desym", "dedup", and "weed", in that order.
    See descriptions of those commands below for more information.

count \<envvar\>

:   Parses the environment variable value into items (usually directories) and outputs a count
    of how many items were found.

dedup \<envvar\> \[topdown|bottomup\]

:   Modifies the value of the environment variable by eliminating literal duplicates within
    listed items (usually directories). If 'topdown' is specified (also the default), then
    the first item match is kept. If 'bottomup' is specified, then the last item match is kept. 

desym \<envvar\>

:   Modifies the value of the environment variable by scanning the items (usually directories)
    withing the enviroment variable value. Each time an item is found that is a symbolic link,
    the item is replaced with its defererenced value. If no symbolic links are found, then the
    value of the environment variable is unchanged.

dump \<envvar\>

:   Parses the environment variable value into items (usually directories) and outputs each item
    on a separate line.

erase \<envvar\> @\<position-number\>

:   Modifies the environment variable by eliminating the item in the specifid position
    (starting with 1). If the position number is greater than the number of items, then
    the value of the environment variable is not modified.

erase \<envvar\> \<item-or-dir\> \[\<number-of-times\>\]

:   Looks for the specified item (usually a directory) within the environment variable value
    and eliminates it up to the specified number of times (in case the item was listed more
    than once). The default number of times is 1. If the item is not found, then the value
    of the environment variable is not modified. (See also the "remove" command).

find \<envvar\> \<item-or-dir\> 

:   Looks for an item (usually a directrory) within the value of an environment variable and
    outputs the position number (starting with 1) at which the item was first found. If the
    item is not found, then nothing is output.

get \<envvar\> \[@\]\<position-number\>

:   Outputs the position-number specified nth item (usually a directory) within the environment
    variable. The position number starts with 1 (one). If position number is greater than the
    count of items, then nothing is output.

insert \<envvar\> \<new-item-or-dir\> before|after \<old-item-or-dir\>

:   Modifies the value of the environment variable such that the specified new item (usually a
    directory) is placed immediately before (if "before" was specified) or after (if "after is
    specified) the first location of the old item (also usually a diectory). It the old item is
    not found, then the new item is appended to the end.

insert \<envvar\> \<new-item-or-dir\> before|after @\<position-number\>

:   Modifies the value of the environment variable such that the specified new item (usually a
    directory) is placed immediately before (if "before" was specified) or after (if "after is
    specified) the numeric position number specified. It the position number is greater than
    the number of items, then the new item is appended to the end.

prepend \<envvar\> \<item-or-dir\>

:   Modifies the value of the environment variable so that the item (usually a directory) is
    placed as the very fist item of the new environment variable value.

remove \<envvar\> \<item-or-dir\> \[\<number-of-times\>\]

:   Looks for the specified item (usually a directory) or any symbolic link equivalent within
    the environment variable value and eliminates it up to the specified number of times (in case
    the item or equivalent was listed more than once). The default number of times is 1. If the
    item is not found, then the value of the environment variable is not modified. (See also the
    "erase" command).

remove \<envvar\> @\<position-number\>

:   Modifies the environment variable by eliminating the item in the specifid position
    (starting with 1). If the position number is greater than the number of items, then
    the value of the environment variable is not modified.

reverse \<envvar\>

:   Modifies the value of the environment variable by reversing the order that items (usually
    directories) are listed.

show \<envvar\>

:   Displays both the raw value of the environment variable and also breaks apart the items
    (usually directories) within the environment variable value into items which are displayed
    as a numbered list, one item per line.

weed \<envvar\>

:   Modifies the value of the environment variable by scanning the items (usually directories)
    withing the enviroment variable value. Each time an item is found that is directory or file
    that actually exists, it is eliminated. If all items exist, then the value of the environment
    variable is unchanged.
