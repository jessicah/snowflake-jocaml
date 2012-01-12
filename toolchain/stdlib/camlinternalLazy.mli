(***********************************************************************)
(*                                                                     *)
(*                           Objective Caml                            *)
(*                                                                     *)
(*            Damien Doligez, projet Para, INRIA Rocquencourt          *)
(*                                                                     *)
(*  Copyright 1997 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the GNU Library General Public License, with    *)
(*  the special exception on linking described in file ../LICENSE.     *)
(*                                                                     *)
(***********************************************************************)

(* $Id: camlinternalLazy.mli 9081 2008-10-14 07:37:28Z maranget $ *)

(* Internals of forcing lazy values *)

exception Undefined;;

val force_lazy_block : 'a lazy_t -> 'a ;;

val force_val_lazy_block : 'a lazy_t -> 'a ;;

val force : 'a lazy_t -> 'a ;;
val force_val : 'a lazy_t -> 'a ;;
