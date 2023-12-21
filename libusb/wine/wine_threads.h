#ifndef WINE_THREADS_H
#define WINE_THREADS_H

#include "libusb.h"

typedef void *(LIBUSB_CALL *thread_start_routine) (void *);

typedef int (LIBUSB_CALL *thread_create_delegate)(int32_t* thread_id, thread_start_routine start_routine, void* args);
typedef int (LIBUSB_CALL *thread_join_delegate)(int32_t thread_id);

extern thread_create_delegate thread_create_ext_impl;
extern thread_join_delegate thread_join_ext_impl;

void LIBUSB_CALL li6_set_thread_delegates(thread_create_delegate thread_create_impl, thread_join_delegate thread_join_impl);

#endif
