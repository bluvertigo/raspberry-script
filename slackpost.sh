#!/bin/bash


c_file=/home/pi/raspberry-script/config.cfg

source $c_file
echo "File Loaded"


# Usage: slackpost <token> <channel> <message>

# Enter the name of your slack host here - the thing that appears in your URL:
# https://slackhost.slack.com/
#slackhost=""

if [[ $hooks == "" ]]
then
        echo "No token specified"
        exit 1
fi

#channel=""
if [[ $channel == "" ]]
then
        echo "No channel specified"
        exit 1
fi

text=$1

if [[ $text == "" ]]
then
        echo "No text specified"
        exit 1
fi

escapedText=$(echo $text | sed 's/"/\"/g' | sed "s/'/\'/g" )
json="{\"channel\": \"#$channel\", \"text\": \"$escapedText\", \"username\": \"webhookbot\"}"

#curl -s -d "payload=$json" "https://$slackhost.slack.com/services/hooks/incoming-webhook?token=$token"

curl -X POST --data-urlencode "payload=$json" "https://hooks.slack.com/services/$hooks"
