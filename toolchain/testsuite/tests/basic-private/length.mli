(* $Id: length.mli 11113 2011-07-07 14:32:00Z maranget $

A testbed file for private type abbreviation definitions.

We define a Length module to implement positive integers.

*)

type t = private int;;

val make : int -> t;;

external from : t -> int = "%identity";;
