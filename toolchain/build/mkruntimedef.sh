#!/bin/sh
# $Id: mkruntimedef.sh 10526 2010-06-04 20:01:14Z maranget $
echo 'let builtin_exceptions = [|'; \
sed -n -e 's|.*/\* \("[A-Za-z_]*"\) \*/$|  \1;|p' byterun/fail.h | \
sed -e '$s/;$//'; \
echo '|]'; \
echo 'let builtin_primitives = [|'; \
sed -e 's/.*/  "&";/' -e '$s/;$//' byterun/primitives; \
echo '|]'
