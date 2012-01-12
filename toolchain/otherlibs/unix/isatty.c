/***********************************************************************/
/*                                                                     */
/*                           Objective Caml                            */
/*                                                                     */
/*            Xavier Leroy, projet Gallium, INRIA Rocquencourt         */
/*                                                                     */
/*  Copyright 2006 Institut National de Recherche en Informatique et   */
/*  en Automatique.  All rights reserved.  This file is distributed    */
/*  under the terms of the GNU Library General Public License, with    */
/*  the special exception on linking described in file ../../LICENSE.  */
/*                                                                     */
/***********************************************************************/

/* $Id: isatty.c 8113 2007-03-23 09:01:11Z maranget $ */

#include <mlvalues.h>
#include "unixsupport.h"

CAMLprim value unix_isatty(value fd)
{
  return (Val_bool(isatty(Int_val(fd))));
}
