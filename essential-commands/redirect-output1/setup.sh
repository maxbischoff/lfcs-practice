#!/bin/bash
USER=$(basename $(pwd))

# set up the task prerequisites
mkdir /opt/EC001/
touch /opt/EC001/stdout.txt
touch /opt/EC001/stderr.txt
echo "This should not be removed" > /opt/EC001/both.txt
chown -R $USER /opt/EC001/

mv print.sh /usr/local/bin/test_printer
chown $USER /usr/local/bin/test_printer
chmod +x /usr/local/bin/test_printer

# set up the solution
mkdir /opt/solutions_EC001/
mv solution/*.txt /opt/solutions_EC001/

mv solution/checker.sh /usr/local/bin/check_solution
chmod +x /usr/local/bin/check_solution

rmdir solution
