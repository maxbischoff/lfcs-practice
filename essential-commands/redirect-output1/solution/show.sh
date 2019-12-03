#!/bin/bash

case "${1}" in
"1")
    echo 'test_printer > /opt/EC001/stdout.txt'
    ;;
"2")
    echo 'test_printer 2> /opt/EC001/stderr.txt'
    ;;
"3")
    echo 'test_printer >> /opt/EC001/both.txt 2>&1'
    ;;
*)
    echo "Usage: ${0} [TASK_NUMBER]"
    ;;
esac
