# essential-commands: redirect-output1

Run the docker container using `docker run -it maxbischoff/essential-commands_redirect-output1`, or execute the setup.sh script locally to set up the task.

## Task Description
An executable named `test_printer` is placed in `/usr/local/bin`, that will output text to both `STDOUT` and `STDERR`.

1. Run `test_printer` and redirect *only* it's standard output to `/opt/EC001/stdout.txt`
2. Run `test_printer` again but this time redirect *only* it's standard error to `/opt/EC001/stderr.txt`
3. Run `test_printer` a third time and redirect both it's standard output and error to `/opt/EC001/both.txt`, *appending* it to the existing file.