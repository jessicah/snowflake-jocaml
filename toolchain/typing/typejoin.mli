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

(* $Id: typejoin.mli 7100 2005-10-04 16:19:18Z maranget $ *)

val get_replies : Typedtree.expression -> Types.kont_locs

exception MissingLeft of Ident.t
exception MissingRight of Ident.t
exception Double of Ident.t * Location.t * Location.t

val delta : Types.kont_locs -> Types.kont_locs -> Types.kont_locs

val inter :
   Location.t ->
   Types.kont_locs -> Types.kont_locs -> Types.kont_locs
