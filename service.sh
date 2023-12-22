API="$(getprop ro.build.version.sdk)"
if [ "$API" -ge 34 ]; then
    SYSTEM_CERTS_PATH=/apex/com.android.conscrypt/cacerts
    pids=$(pgrep -f zygote)
    for pid in $pids; do
        echo "mount for $pid $(cat /proc/"$pid"/cmdline)"
        nsenter --mount="/proc/$pid/ns/mnt" mount -t overlay CERTS -olowerdir=/mnt/cert:$SYSTEM_CERTS_PATH $SYSTEM_CERTS_PATH
    done
fi
