#include "wine_threads.h"
#include "libusbi.h"

#include <stdio.h>

thread_create_delegate thread_create_ext_impl;
thread_join_delegate thread_join_ext_impl;

void API_EXPORTED li6_set_thread_delegates(thread_create_delegate thread_create_impl, thread_join_delegate thread_join_impl)
{
	thread_create_ext_impl = thread_create_impl;
	thread_join_ext_impl = thread_join_impl;
}
