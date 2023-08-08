#include <windef.h>

signed short WINAPI fork_wrapper ()
{
    return fork();
}