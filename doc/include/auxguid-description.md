*auxguid* is an executable bash script which, by default, uses a custom algorithm
to generate a 32 hex xharacter 128 bit GUID (Globally Unigue IDentifier) sometimes
also called a UUID (Universally Unique IDentifier) using nothing by bash.
(See <https://en.wikipedia.org/wiki/Universally_unique_identifier>).

Optionally, if the "--uuidgen" option is specified and if the optional Linux program
"uuidgen" is installed then that program is used to generate the GUID/UUID.
