MODDIR=${0%/*}
API="$(getprop ro.build.version.sdk)"
if [ "$API" -ge 34 ]; then
    SYSTEM_CERTS_PATH=/system/etc/security/cacerts
    mkdir -p /mnt/cert
    cp "$MODDIR"/$SYSTEM_CERTS_PATH/* /mnt/cert
    /system/bin/chcon u:object_r:system_security_cacerts_file:s0 /mnt/cert
    chmod 755 /mnt/cert
    /system/bin/chcon u:object_r:system_security_cacerts_file:s0 /mnt/cert/*
    chmod 644 /mnt/cert/*
fi
