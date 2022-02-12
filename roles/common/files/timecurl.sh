#!/bin/bash
#
# Measure HTTP request/response times using Curl.
# (c) 2022 Josef Hammer (josef.hammer@aau.at)

# man curl:
#
# __time_namelookup__
# The time, in seconds, it took from the start until the name resolving was completed.
#
# __time_connect__   
# The time, in seconds, it took from the start until the TCP connect to the remote host (or proxy) was completed.
#
# __time_appconnect__
# The time, in seconds, it took from the start until the SSL/SSH/etc connect/handshake to the remote host was completed. (Added in 7.19.0)
#
# __time_pretransfer__
# The time, in seconds, it took from the start until the file transfer was just about to begin. This includes all pre-transfer commands 
# and negotiations that are specific to the particular protocol(s) involved.
#
# __time_redirect__  
# The  time,  in seconds, it took for all redirection steps including name lookup, connect, pretransfer and transfer before the final
# transaction was started. time_redirect shows the complete execution time for multiple redirections. (Added in 7.12.3)
#
# __time_starttransfer__
# The time, in seconds, it took from the start until the first byte was just about to be transferred. This includes
# time_pretransfer and also the time the server needed to calculate the result.
#
# __time_total__
# The total time, in seconds, that the full operation lasted.
#
# __num_connects   
# Number of new connects made in the recent transfer.

if [[ $# -lt 1 ]]
then
    echo "Usage: $0 [loop <numRequests>] [sleep <numSeconds>] [curl options / URLs]"
    echo "Use '-L' to follow redirections."
    echo ""
    exit 1
fi

NUM_REQUESTS=1
SLEEP=0

if [[ $1 == "loop" ]]; then
    shift
    if [[ $1 -gt 1 ]]; then
        NUM_REQUESTS=$1
    fi
    shift
fi
if [[ $1 == "sleep" ]]; then
    shift
    if [[ $1 -gt 0 ]]; then
        SLEEP=$1
    fi
    shift
fi

echo "[{"

for ((i=1; i<=$NUM_REQUESTS; i++))
do
    if [[ $i -gt 1 ]]; then 
        echo "},{"
        sleep "$SLEEP"
    fi
    
    curl -s -o /dev/null -w @- "$@" <<'EOF'
            "remote":  "%{remote_ip}:%{remote_port}",\n
         "http_code":  %{http_code},\n
      "num_connects":  %{num_connects},\n
   "time_namelookup":  %{time_namelookup},\n
  "time_pretransfer":  %{time_pretransfer},\n
"time_starttransfer":  %{time_starttransfer},\n
\n
      "time_connect":  %{time_connect},\n
        "time_total":  %{time_total}\n
EOF
done
echo "}]"
