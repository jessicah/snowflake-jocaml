(***********************************************************************)
(*                                                                     *)
(*                           Objective Caml                            *)
(*                                                                     *)
(*            Luc Maranget, projet Moscova, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 2005 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* $Id: join_debug.mli 8861 2008-04-07 09:43:59Z maranget $ *)

open Printf
val  verbose : int

type 'a t = string -> (('a, unit, string, unit) format4 -> 'a)

val debug : 'a t
val debug0 : 'a t
val debug1 : 'a t
val debug2 : 'a t
val debug3 : 'a t
