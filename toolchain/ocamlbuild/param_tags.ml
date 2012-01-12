(***********************************************************************)
(*                             ocamlbuild                              *)
(*                                                                     *)
(*  Nicolas Pouillard, Berke Durak, projet Gallium, INRIA Rocquencourt *)
(*                                                                     *)
(*  Copyright 2007 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the Q Public License version 1.0.               *)
(*                                                                     *)
(***********************************************************************)


(* Original author: Romain Bardou *)

module StringSet = Set.Make(String)
module SSOSet = Set.Make(struct
  type t = string * string option
  let compare = Pervasives.compare
end)

(* tag name -> tag action (string -> unit) *)
let declared_tags = Hashtbl.create 17

let acknowledged_tags = ref SSOSet.empty

let only_once f =
  let instances = ref StringSet.empty in
  fun param ->
    if StringSet.mem param !instances then ()
    else begin
      instances := StringSet.add param !instances;
      f param
    end

let declare name action =
  Hashtbl.add declared_tags name (only_once action)

let acknowledge tag =
  let tag = Lexers.tag_gen (Lexing.from_string tag) in
  acknowledged_tags := SSOSet.add tag !acknowledged_tags

let really_acknowledge (name, param) =
  match param with
    | None ->
        if Hashtbl.mem declared_tags name then
          Log.eprintf "Warning: tag %S expects a parameter" name
    | Some param ->
        let actions = List.rev (Hashtbl.find_all declared_tags name) in
        if actions = [] then
          Log.eprintf "Warning: tag %S does not expect a parameter, but is used with parameter %S" name param;
        List.iter (fun f -> f param) actions

let init () =
  SSOSet.iter really_acknowledge !acknowledged_tags

let make = Printf.sprintf "%s(%s)"
