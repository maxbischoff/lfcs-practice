#!/bin/bash

failed=0

if cmp /opt/EC001/stdout.txt /opt/solutions_EC001/stdout.txt >/dev/null 2>&1; then
    echo "1: Correct"
else
    echo "1: Incorrect, see diff below:"
    diff /opt/EC001/stdout.txt /opt/solutions_EC001/stdout.txt
    echo
    ((failed=failed+1))
fi


if cmp /opt/EC001/stderr.txt /opt/solutions_EC001/stderr.txt >/dev/null 2>&1; then
    echo "2: Correct"
else
    echo "2: Incorrect, see diff below:"
    diff /opt/EC001/stderr.txt /opt/solutions_EC001/stderr.txt
    echo
    ((failed=failed+1))
fi

if cmp /opt/EC001/both.txt /opt/solutions_EC001/both.txt >/dev/null 2>&1; then
    echo "3: Correct"
else
    echo "3: Incorrect, see diff below:"
    diff /opt/EC001/both.txt /opt/solutions_EC001/both.txt
    echo
    ((failed=failed+1))
fi

exit $failed
