#!/bin/sh
printf "Setting up 644 permissions for files\n"
find /home/danielmacuare -type f -print0 | xargs -0 chmod 644

printf "Setting up 755 permissions for folders\n"
find /home/danielmacuare -type d -print0 | xargs -0 chmod 755
