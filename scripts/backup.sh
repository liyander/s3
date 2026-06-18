set -eu

timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
archive="/tmp/backup-${timestamp}.tar.gz"
key="${S3_PREFIX:-backups}/backup-${timestamp}.tar.gz"

tar -czf "${archive}" -C /backup-source .
aws s3 cp "${archive}" "s3://${S3_BUCKET}/${key}"
echo "${key}" > /tmp/latest-backup-key
aws s3 cp /tmp/latest-backup-key "s3://${S3_BUCKET}/${S3_PREFIX:-backups}/latest-backup-key"
