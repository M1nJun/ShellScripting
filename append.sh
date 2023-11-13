#!/bin/bash

tag=$(grep -w "^$1" /etc/fwd.conf)
path=$(grep -w "$2\$" /etc/fwd.conf)
restart="true"
if [ -n "$tag" ]
then
  read -p "Tag $1 already exists. Replace it?[y/n]" yn
  if [ yn != "n" ]
  then
    rest=$(grep -v "^$1" /etc/fwd.conf)
    echo $rest > /etc/fwd.conf
    echo "$1 $2" >> /etc/fwd.conf
  else
    restart="false"
  fi
else
  if [ -n "$path" ]
  then
    read -p "Path $2 already exists. Replace it?[y/n]" yn
    if [ yn != "n" ]
    then
      rest=$(grep -v " $2\$" /etc/fwd.conf)
      echo $rest > /etc/fwd.conf
      echo "$1 $2" >> /etc/fwd.conf
    else
      restart="false"
  else
    echo "$1 $2" >> /etc/fwd.conf
  fi
fi
if [ $restart == "true" ]
then
  kill -2 $(cat /run/fwd.pid)
  /opt/fwd/fwd
fi