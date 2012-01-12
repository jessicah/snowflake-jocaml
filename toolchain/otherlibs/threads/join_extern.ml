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

(* $Id: join_extern.ml 7205 2005-10-27 16:29:22Z maranget $ *)

external thread_new : (unit -> unit) -> Thread.t = "thread_new"
external thread_uncaught_exception : exn -> unit = "thread_uncaught_exception"
