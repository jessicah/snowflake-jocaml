/***********************************************************************/
/*                                                                     */
/*                           Objective Caml                            */
/*                                                                     */
/*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         */
/*                                                                     */
/*  Copyright 1999 Institut National de Recherche en Informatique et   */
/*  en Automatique.  All rights reserved.  This file is distributed    */
/*  under the terms of the GNU Library General Public License, with    */
/*  the special exception on linking described in file ../../LICENSE.  */
/*                                                                     */
/***********************************************************************/

/* $Id: elf.c 4255 2002-01-16 16:32:52Z peskine $ */

#include <stdio.h>

int main(int argc, char ** argv)
{
#ifdef __ELF__
  printf("elf\n");
#else
  printf("aout\n");
#endif
  return 0;
}
