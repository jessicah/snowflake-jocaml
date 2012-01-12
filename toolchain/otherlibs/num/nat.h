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

/* $Id: nat.h 10509 2010-06-04 19:17:18Z maranget $ */

/* Nats are represented as unstructured blocks with tag Custom_tag. */

#define Digit_val(nat,pos) (((bng) Data_custom_val(nat))[pos])
