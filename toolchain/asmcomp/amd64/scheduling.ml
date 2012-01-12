(***********************************************************************)
(*                                                                     *)
(*                           Objective Caml                            *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 2000 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* $Id: scheduling.ml 6336 2004-05-27 09:18:38Z maranget $ *)

open Schedgen (* to create a dependency *)

(* Scheduling is turned off because the processor schedules dynamically
   much better than what we could do. *)

let fundecl f = f
