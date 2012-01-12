/***********************************************************************/
/*                                                                     */
/*                           Objective Caml                            */
/*                                                                     */
/*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         */
/*                                                                     */
/*  Copyright 1996 Institut National de Recherche en Informatique et   */
/*  en Automatique.  All rights reserved.  This file is distributed    */
/*  under the terms of the GNU Library General Public License, with    */
/*  the special exception on linking described in file ../../LICENSE.  */
/*                                                                     */
/***********************************************************************/

/* $Id: channels.c 11113 2011-07-07 14:32:00Z maranget $ */

#include <mlvalues.h>
#include <alloc.h>
#include <io.h>
#include <memory.h>
#include "unixsupport.h"
#include <fcntl.h>

extern long _get_osfhandle(int);
extern int _open_osfhandle(long, int);

int win_CRT_fd_of_filedescr(value handle)
{
  if (CRT_fd_val(handle) != NO_CRT_FD) {
    return CRT_fd_val(handle);
  } else {
    int fd = _open_osfhandle((long) Handle_val(handle), O_BINARY);
    if (fd == -1) uerror("channel_of_descr", Nothing);
    CRT_fd_val(handle) = fd;
    return fd;
  }
}

CAMLprim value win_inchannel_of_filedescr(value handle)
{
  CAMLparam1(handle);
  CAMLlocal1(vchan);
  struct channel * chan;

  chan = caml_open_descriptor_in(win_CRT_fd_of_filedescr(handle));
  if (Descr_kind_val(handle) == KIND_SOCKET)
    chan->flags |= CHANNEL_FLAG_FROM_SOCKET;
  vchan = caml_alloc_channel(chan);
  CAMLreturn(vchan);
}

CAMLprim value win_outchannel_of_filedescr(value handle)
{
  CAMLparam1(handle);
  CAMLlocal1(vchan);
  int fd;
  struct channel * chan;

  chan = caml_open_descriptor_out(win_CRT_fd_of_filedescr(handle));
  if (Descr_kind_val(handle) == KIND_SOCKET)
    chan->flags |= CHANNEL_FLAG_FROM_SOCKET;
  vchan = caml_alloc_channel(chan);
  CAMLreturn(vchan);
}

CAMLprim value win_filedescr_of_channel(value vchan)
{
  CAMLparam1(vchan);
  CAMLlocal1(fd);
  struct channel * chan;
  HANDLE h;

  chan = Channel(vchan);
  if (chan->fd == -1) uerror("descr_of_channel", Nothing);
  h = (HANDLE) _get_osfhandle(chan->fd);
  if (chan->flags & CHANNEL_FLAG_FROM_SOCKET)
    fd = win_alloc_socket((SOCKET) h);
  else
    fd = win_alloc_handle(h);
  CRT_fd_val(fd) = chan->fd;
  CAMLreturn(fd);
}

CAMLprim value win_handle_fd(value vfd)
{
  int crt_fd = Int_val(vfd);
  value res = win_alloc_handle_or_socket((HANDLE) _get_osfhandle(crt_fd));
  CRT_fd_val(res) = crt_fd;
  return res;
}
