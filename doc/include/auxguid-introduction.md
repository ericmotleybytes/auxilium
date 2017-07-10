An executable script.
This script generates a pseudo random 128-bit (32 hex character) GUID (Globally
Unique IDentifier) sometimes also known as a UUID (Universally Unique IDentifier).
There are some standards for GUID/UUID generation, but none are universal and even the
definition of GUID and UUID is under debate
(see <https://en.wikipedia.org/wiki/Universally_unique_identifier>). This script uses
its own algorithm to generate the GUID. The GUID is not cryptogrphically random,
but it is sufficiently random such that the chances of any two independently generated
GUIDs ever being the same (colliding) is astronomically low. Most programming languages
have GUID/UUID generation facilities that are probably more standardized, but it is
sometimes really convenient to have a good GUID generater that does not need anything
but bash.
