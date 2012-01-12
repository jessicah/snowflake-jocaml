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

(* $Id: join_test.mli 7207 2005-10-28 13:21:13Z maranget $ *)

(* Some values exported for testing purposes *)

open Join_types

val globalize :
    'a ->  Marshal.extern_flags list -> parameter
val localize : parameter -> 'a

