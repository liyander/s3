set -eu

key="${BACKUP_KEY:-}"

if [ -z "${key}" ]; then
  aws s3 cp "s3://${S3_BUCKET}/${S3_PREFIX:-backups}/latest-backup-key" /tmp/latest-backup-key
  key="$(cat /tmp/latest-backup-key)"
fi

aws s3 cp "s3://${S3_BUCKET}/${key}" /tmp/restore.tar.gz
mkdir -p /restore-target
tar -xzf /tmp/restore.tar.gz -C /restore-target
find /restore-target -maxdepth 3 -type f | sort
