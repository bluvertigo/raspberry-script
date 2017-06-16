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

#make list of files to work with that are at least x minutes old
     for i in $(find $x/ -amin +"$age"|grep DCS|grep avi|sort) ; do echo $i >> $x/$date.lst ; done

#proceed if there are any videos
if [ -a $x/$date.lst ]
then

  #upload video
      if [ -a $x/$fileprefix$date.avi ]
      then
        result=$(/usr/local/bin/youtube-upload --email=$ytemail --password=$ytpassword --private --api-upload --title="$fileprefix$date" --description="$LENGTH" --category="Personal" --unlisted $x/$fileprefix$date.avi)
      fi

  #check to make sure that the upload returned a video URL
      if [[ $result == *http* ]]
      then
        #send email with video URL
        echo -e "File: $fileprefix$date\nTime: $LENGTH\nURL: $result\nFiles contained:\n$(cat $x/$date.lst)" | echo #mailx -v -s "$emailsubject" -S smtp-use-starttls -S ssl-verify=ignore -S smtp-auth=login -S smtp=smtp://smtp.gmail.com:587 -S from="$emailfrom" -S smtp-auth-user="$emailuser" -S smtp-auth-password="$emailpassword" -S ssl-verify=ignore -S nss-config-dir=~/.mozilla/firefox/yyyyyyyy.default/ "$emailto"

        #rename video to prevent processing it again
        #for i in $(cat $x/$date.lst); do mv "$i" "${i/DCS/YOUTUBE}"; done
      fi

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
