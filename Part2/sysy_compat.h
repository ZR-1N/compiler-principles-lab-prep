/* C-compatible declarations for the SysY runtime functions used in reference.sy.
   This header is ONLY for Clang's independent C reference compilation. */
#ifndef SYSY_COMPAT_H
#define SYSY_COMPAT_H
int getint(void);
void putint(int value);
void putch(int value);
#endif
