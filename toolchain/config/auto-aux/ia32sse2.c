/***********************************************************************/
/*                                                                     */
/*                           Objective Caml                            */
/*                                                                     */
/*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         */
/*                                                                     */
/*  Copyright 2003 Institut National de Recherche en Informatique et   */
/*  en Automatique.  All rights reserved.  This file is distributed    */
/*  under the terms of the GNU Library General Public License, with    */
/*  the special exception on linking described in file ../../LICENSE.  */
/*                                                                     */
/***********************************************************************/

/* $Id: ia32sse2.c 6857 2005-05-04 20:30:00Z habouzit $ */

/* Test whether IA32 assembler supports SSE2 instructions */

int main()
{
  asm("pmuludq %mm1, %mm0");
  asm("paddq %mm1, %mm0");
  asm("psubq %mm1, %mm0");
  return 0;
}
