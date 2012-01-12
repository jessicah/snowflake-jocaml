(*************************************************************************)
(*                                                                       *)
(*                Objective Caml LablTk library                          *)
(*                                                                       *)
(*            Jacques Garrigue, Kyoto University RIMS                    *)
(*                                                                       *)
(*   Copyright 1999 Institut National de Recherche en Informatique et    *)
(*   en Automatique and Kyoto University.  All rights reserved.          *)
(*   This file is distributed under the terms of the GNU Library         *)
(*   General Public License, with the special exception on linking       *)
(*   described in file ../../../LICENSE.                                 *)
(*                                                                       *)
(*************************************************************************)

(* $Id: list2.ml 4255 2002-01-16 16:32:52Z peskine $ *)

open StdLabels

let exclude x l = List.filter l ~f:((<>) x)

let rec flat_map ~f = function
    [] -> []
  | x :: l -> f x @ flat_map ~f l
