#!/bin/sh
#argument 1: the location of the m4 program, also the place where the wrapper will be created
#argument 2: the location to move the m4 program to

mv "$1" "$2"

printf '#!/bin/sh\n' >> "$1"
printf 'if [ "$2" = "conftest.m4f" ];\n' >> "$1"
printf 'then\n' >> "$1"
printf '/usr/bin/m4.backup -F conftest.m4f </dev/null 2>/dev/null\n' >> "$1"
printf 'else\n' >> "$1"
printf '/usr/bin/m4.backup "$@"\n' >> "$1"
printf 'fi\n' >> "$1"
printf 'exit 0\n' >> "$1"

chmod +x "$1"