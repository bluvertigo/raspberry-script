#!/bin/bash
     
c_file=/home/pi/raspberry-script/config.cfg

unknown=`cat $c_file | grep -Evi "^(#.*|[a-z]*='[a-z0-9 ]*')$"`
if [ -n "$unknown" ]; then
 echo "Error in config file. Not allowed lines:"
 echo $unknown
 exit 1
fi
source $c_file
echo "File Loaded"


#make list of files to work with that are at least x minutes old
     for i in $(find $x/ | grep -E 'avi|mov|mpeg|mp4'  | sort) ; do echo $i >> $x/$date.lst ; done

#proceed if there are any videos
if [ -a $x/$date.lst ]
then


for filename in $(cat $x/$date.lst);
do
  #upload video
        if [ -a $filename ]
        then
                echo $filename
        fi
done


  #delete helper files
      if [ -a $x/$date.tmp ]
      then
        rm -f $x/$date.tmp
      fi
      if [ -a $x/$date.lst ]
      then
        rm -f $x/$date.lst
      fi
fi
