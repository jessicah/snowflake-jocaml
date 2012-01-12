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

/* $Id: sizes.c 4255 2002-01-16 16:32:52Z peskine $ */

#include <stdio.h>

int main(int argc, char **argv)
{
  printf("%d %d %d %d\n",
         sizeof(int), sizeof(long), sizeof(long *), sizeof(short));
  return 0;
}
