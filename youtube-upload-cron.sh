#!/bin/bash
#setup variables
     x="/share/cam" #base dir to search
     date=$(date +"%Y%m%d%H%M") #date used throughout script
     fileprefix="yt_"
     ytemail="youremail" #your youtube email account
     ytpassword="password" #your youtube password
     emailfrom="youremail(Your Name)" #your email address and from name
     emailuser="youremail" #your gmail address
     emailpassword="password" #your gmail password
     emailto="youremail" #email to send message to
     emailsubject="Security Camera Video Recorded" #email subject
     
c_file=config_file_test

unknown=`cat $c_file | grep -Evi "^(#.*|[a-z]*='[a-z0-9 ]*')$"`
if [ -n "$unknown" ]; then
 echo "Error in config file. Not allowed lines:"
 echo $unknown
 exit 1
fi
source $c_file
echo "File Loaded"
