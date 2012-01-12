#!/bin/sh
# $Id: world.byte.sh 10526 2010-06-04 20:01:14Z maranget $
set -e
cd `dirname $0`/..
. build/targets.sh
set -x
$OCAMLBUILD $@ \
  $STDLIB_BYTE $OCAMLC_BYTE $OCAMLLEX_BYTE $OCAMLOPT_BYTE $TOPLEVEL $TOOLS_BYTE \
  $OTHERLIBS_BYTE $OCAMLBUILD_BYTE $DEBUGGER $OCAMLDOC_BYTE $CAMLP4_BYTE
