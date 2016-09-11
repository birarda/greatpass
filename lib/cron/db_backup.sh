#!/bin/bash

NOW=$(date +"%Y%m%d_%H%M%S")
cd /home/birarda/pg-backups;/usr/bin/pg_dump -U postgres greatpass_production | gzip > gp-db.$NOW.sql.gz

/usr/local/bin/aws s3 mv gp-db.$NOW.sql.gz s3://gp-db-prod/db-backup/$1/
