#!/bin/bash

c_file=/home/pi/raspberry-script/config.cfg


#unknown=`cat $c_file | grep -Evi "^(#.*|[a-z]*='[a-z0-9 ]*')$"`
#if [ -n "$unknown" ]; then
# echo "Error in config file. Not allowed lines:"
# echo $unknown
# exit 1
#fi
source $c_file
echo "File Loaded"

# make sure a copy directory is there otherwise make it
if [ -d $COPY_DIR ]; then
echo “You have a save directory”
else
mkdir $COPY_DIR
fi

#make list of files to work with that are at least x minutes old
     for i in $(find $x/ | grep -E 'avi|mov|mpeg|mp4|MOV'  | sort) ; do echo $i >> $x/$date.lst ; done

#proceed if there are any videos
if [ -a $x/$date.lst ]
then


for filename in $(cat $x/$date.lst);
do
  #upload video
        if [ -a $filename ]
        then
                $(/home/pi/raspberry-script/slackpost.sh "Inizio caricamento video")
		# result=$(youtube-upload --privacy="unlisted" --title="$filename"  $filename)
       		result="6dwqZw0j_jY"
		echo -e "***\nFile: $result\n"
		if echo $result | grep -Eq "^([A-Za-z0-9_\-]{11})$"
		then
    			$(/home/pi/raspberry-script/slackpost.sh "caricato video https://www.youtube.com/watch?v=$result")
		else
			$(/home/pi/raspberry-script/slackpost.sh "Errore: $result")

		fi
		mv $filename $COPY_DIR
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
