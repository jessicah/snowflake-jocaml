(***********************************************************************)
(*                                                                     *)
(*                           Objective Caml                            *)
(*                                                                     *)
(*              Xavier Leroy, projet Cristal, INRIA Rocquencourt       *)
(*                                                                     *)
(*  Copyright 1996 Institut National de Recherche en Informatique et   *)
(*  en Automatique.  All rights reserved.  This file is distributed    *)
(*  under the terms of the GNU Library General Public License, with    *)
(*  the special exception on linking described in file ../LICENSE.     *)
(*                                                                     *)
(***********************************************************************)


(** A generic lexical analyzer.


   This module implements a simple ``standard'' lexical analyzer, presented
   as a function from character streams to token streams. It implements
   roughly the lexical conventions of Caml, but is parameterized by the
   set of keywords of your language.


   Example: a lexer suitable for a desk calculator is obtained by
   {[     let lexer = make_lexer ["+";"-";"*";"/";"let";"="; "("; ")"]  ]}

   The associated parser would be a function from [token stream]
   to, for instance, [int], and would have rules such as:

   {[
           let parse_expr = parser
                  [< 'Int n >] -> n
                | [< 'Kwd "("; n = parse_expr; 'Kwd ")" >] -> n
                | [< n1 = parse_expr; n2 = parse_remainder n1 >] -> n2
           and parse_remainder n1 = parser
                  [< 'Kwd "+"; n2 = parse_expr >] -> n1+n2
                | ...
   ]}
*)

(** The type of tokens. The lexical classes are: [Int] and [Float]
   for integer and floating-point numbers; [String] for
   string literals, enclosed in double quotes; [Char] for
   character literals, enclosed in single quotes; [Ident] for
   identifiers (either sequences of letters, digits, underscores
   and quotes, or sequences of ``operator characters'' such as
   [+], [*], etc); and [Kwd] for keywords (either identifiers or
   single ``special characters'' such as [(], [}], etc). *)
type token =
    Kwd of string
  | Ident of string
  | Int of int
  | Float of float
  | String of string
  | Char of char

val make_lexer : string list -> char Stream.t -> token Stream.t
(** Construct the lexer function. The first argument is the list of
   keywords. An identifier [s] is returned as [Kwd s] if [s]
   belongs to this list, and as [Ident s] otherwise.
   A special character [s] is returned as [Kwd s] if [s]
   belongs to this list, and cause a lexical error (exception
   [Parse_error]) otherwise. Blanks and newlines are skipped.
   Comments delimited by [(*] and [*)] are skipped as well,
   and can be nested. *)
