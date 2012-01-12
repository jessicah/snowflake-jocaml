(***********************************************************************)
(*                                                                     *)
(*                           Objective Caml                            *)
(*                                                                     *)
(*          Damien Doligez, projet Gallium, INRIA Rocquencourt         *)
(*                                                                     *)
(*  Copyright 2007 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)

(* $Id: annot.mli 9081 2008-10-14 07:37:28Z maranget $ *)

(* Data types for annotations (Stypes.ml) *)

type call = Tail | Stack | Inline;;

type ident =
  | Iref_internal of Location.t (* defining occurrence *)
  | Iref_external
  | Idef of Location.t          (* scope *)
;;
