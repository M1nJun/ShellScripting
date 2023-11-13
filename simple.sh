#!/bin/bash

exists=$(grep "^$1 " /etc/fwd.conf)
if [ -z $exists ]
then
  echo "$1 $2" >> /etc/fwd.conf
  kill -2 $(cat /run/fwd.pid)
  /opt/fwd/fwd
else
  echo "Tag $1 already exists."
fi