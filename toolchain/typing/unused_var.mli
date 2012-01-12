(***********************************************************************)
(*                                                                     *)
(*                           Objective Caml                            *)
(*                                                                     *)
(*           Damien Doligez, projet Cristal, INRIA Rocquencourt        *)
(*                                                                     *)
(*  Copyright 2004 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* $Id: unused_var.mli 8113 2007-03-23 09:01:11Z maranget $ *)

val warn : Format.formatter -> Parsetree.structure -> Parsetree.structure;;
(* Warn on unused variables; return the second argument. *)
