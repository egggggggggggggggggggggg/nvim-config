skip function malloc
skip function calloc
skip function realloc
skip function free
skip function memcpy
skip function memset
skip function myrealloc
skip function myalloc 
skip function myfree 
skip function printf
skip function fprintf
# C/POSIX libc functions
skip -rfunction ^(__)?(printf|fprintf|sprintf|snprintf|vprintf|vfprintf|vsprintf|vsnprintf)$
skip -rfunction ^(__)?(malloc|calloc|realloc|free)$
skip -rfunction ^(__)?(memcpy|memset|memmove|memcmp|strcmp|strlen)$

# glibc internals
skip -rfunction ^(__|_IO_|__GI_|__libc_).*

# C++ standard library
skip -rfunction ^std::

# System headers / libc source
skip -gfile /usr/include/**
skip -gfile /usr/src/**
