#!/bin/sh

#########################################################################
#                                                                       #
#                            Objective Caml                             #
#                                                                       #
#         Nicolas Pouillard, projet Gallium, INRIA Rocquencourt         #
#                                                                       #
#   Copyright 2008 Institut National de Recherche en Informatique et    #
#   en Automatique.  All rights reserved.  This file is distributed     #
#   under the terms of the Q Public License version 1.0.                #
#                                                                       #
#########################################################################

# $Id: camlp4-byte-only.sh 11113 2011-07-07 14:32:00Z maranget $

set -e
cd `dirname $0`/..
. build/targets.sh
set -x
$OCAMLBUILD $@ byte_stdlib_mixed_mode $OCAMLC_BYTE $OCAMLLEX_BYTE $CAMLP4_BYTE
