#!/bin/bash

if ! [ -f backup-cron ]
then
  echo "Creating cron entry to start backup at: $BACKUP_TIME"
  # Note: Must use tabs with indented 'here' scripts.
  cat <<-EOF >> backup-cron
	AWS_ACCESS_KEY=$AWS_ACCESS_KEY
	AWS_SECRET_KEY=$AWS_SECRET_KEY
	AWS_BUCKET=$AWS_BUCKET
	DB_HOST=$DB_HOST
	DB_NAME=$DB_NAME
	FILE_PATH=$FILE_PATH
	$BACKUP_TIME backup
	EOF
  crontab backup-cron
fi

echo "Current crontab:"
crontab -l

exec "$@"
