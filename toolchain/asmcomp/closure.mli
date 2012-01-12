(***********************************************************************)
(*                                                                     *)
(*                           Objective Caml                            *)
(*                                                                     *)
(*            Xavier Leroy, projet Cristal, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 1996 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* $Id: closure.mli 10507 2010-06-04 19:16:58Z maranget $ *)

(* Introduction of closures, uncurrying, recognition of direct calls *)

val intro: int -> Lambda.lambda -> Clambda.ulambda
