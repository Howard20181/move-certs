set_perm_recursive "$MODPATH/system/etc/security/cacerts" 0 0 0755 0644 "u:object_r:system_security_cacerts_file:s0"
mkdir -p /mnt/cert
cp "$MODPATH"/system/etc/security/cacerts/* /mnt/cert
set_perm_recursive "/mnt/cert" 0 0 0755 0644 "u:object_r:system_security_cacerts_file:s0"
SYSTEM_CERTS_PATH=/system/etc/security/cacerts
if [ "$API" -ge 34 ]; then
  SYSTEM_CERTS_PATH=/apex/com.android.conscrypt/cacerts
fi
pids=$(pgrep -f zygote)
for pid in $pids; do
  echo "mount for $pid $(cat /proc/"$pid"/cmdline)"
  nsenter --mount="/proc/$pid/ns/mnt" mount -t overlay CERTS -olowerdir=/mnt/cert:$SYSTEM_CERTS_PATH $SYSTEM_CERTS_PATH
done
