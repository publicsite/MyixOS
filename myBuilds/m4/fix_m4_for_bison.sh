#!/bin/sh
#argument 1: the location of the m4 program, also the place where the wrapper will be created in the sysroot
#argument 2: the location to move the m4 program in the sysroot
#argument 3: the sysroot

mv "${3}${1}" "${3}${2}"

printf '#!/bin/sh\n' >> "${3}${1}"
printf 'if [ "${2}" = "conftest.m4f" ];\n' >> "${3}${1}"
printf 'then\n' >> "${3}${1}"
printf "${2} -F conftest.m4f </dev/null 2>/dev/null\n" >> "${3}${1}"
printf 'else\n' >> "${3}${1}"
printf "${2} \"\$@\"\n" >> "${3}${1}"
printf 'fi\n' >> "${3}${1}"
printf 'exit 0\n' >> "${3}${1}"

chmod +x "${3}${1}"