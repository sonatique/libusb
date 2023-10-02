#if defined(__WINE__)

#include "libusbi.h"
#include <stdlib.h>
#include <stdio.h>
#include <sys/utsname.h>

int API_EXPORTED li6_uname(struct utsname* details)
{
	return uname(details);
}

void API_EXPORTED * li6_alloc(size_t size)
{
	return malloc(size); /* or valloc ? */
}

void API_EXPORTED li6_free(void* ptr)
{
	free(ptr);
}

#endif
