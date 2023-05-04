#!/bin/bash

if [ $# -eq 0 ]; then
   echo "No arguments supplied"
   echo "Usage:<script name> URL"
   exit 1
fi

declare -r URL=$1

STATUS=$(curl -s -o /dev/null -w "%{http_code}\n" "${URL}")
if [ "${STATUS}" == 200 ] ; then
    echo "${URL} is up and running, returned ${STATUS}"
else                     
    echo "${URL} is down, returned ${STATUS}"
fi
