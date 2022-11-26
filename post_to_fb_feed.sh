#!/bin/bash
# Script written by David Kukulikyan
# Post to the FB feed page about push

# Function validates the count of passed parameters.
# First argument: actual parameters count which passed to the function
# Second argument: expected parameters count that should be passed to the function
function check_argumet_cnt(){
    act_arg_count=$1
    exp_arg_count=$2
    if [ $act_arg_count -ne $exp_arg_count ]; then
        echo "Wrong number of parameters!"
        echo "The count of parameters should be $exp_arg_count."
        exit
    fi
}

# Function gets content to post it to FB page's feed
# Firs argumet: tag_version
# Secong argument: commit_id
# Third argument: fb_access_token
get_message_to_post(){
    check_argumet_cnt "$#" 3
    local release="Release: "$1
    local git_commit_msg=$2
    local commit_id=$3
    local date=$(date +%m-%d-%Y-%H:%M:%S)
    #post_cont="Pushed to the master\nDate: $date\n$release\nCommit message: $git_commit_msg\nCommit id: $commit_id"
    post_cont="Commit id: $commit_id"

}

# Function writes informetion about commit on the FB feed page. 
# Firs argumet: tag_version
# Secong argument: commit_id
function post_to_fb_feed_page(){
    check_argumet_cnt "$#" 2
    url='"https://graph.facebook.com/v15.0/me/feed?"'
    token="--data-urlencode 'access_token=${1}'"
    message="--data-urlencode $'message=${2}'"
    eval "curl -i -X POST ${url} ${message} ${token}"

}

function main() {
    check_argumet_cnt "$#" 4
    get_message_to_post "$2" "$3" "$4"
    post_to_fb_feed_page "$1" "$post_cont"
}


main $1 $2 $3 $4