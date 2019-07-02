#!/bin/sh
#argument 1: the location of the busybox binary
#argument 2: the location of the existing mkdir symlink to replace

rm "$2"

printf '#!/bin/sh\n' >> "$2"
printf 'found=0\n' >> "$2"
printf 'index=0\n' >> "$2"
printf 'while [ "$index" -le "$#" ]; do\n' >> "$2"
printf 'argument="$(eval echo "\${$index}")"\n' >> "$2"
printf 'if [ "$argument" = "--version" ]; then\n' >> "$2"
printf 'found=1\n' >> "$2"
printf 'fi\n' >> "$2"
printf 'index="$(expr $index + 1)"\n' >> "$2"
printf 'done\n' >> "$2"
printf 'if [ "$found" = "0" ]; then\n' >> "$2"
printf '%s mkdir %s\n' "$1" '"$@"' >> "$2"
printf 'fi\n' >> "$2"

chmod +x "$2"