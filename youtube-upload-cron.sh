#!/bin/bash
     
c_file=/home/pi/raspi-script/config.cfg

unknown=`cat $c_file | grep -Evi "^(#.*|[a-z]*='[a-z0-9 ]*')$"`
if [ -n "$unknown" ]; then
 echo "Error in config file. Not allowed lines:"
 echo $unknown
 exit 1
fi
source $c_file
echo "File Loaded"
