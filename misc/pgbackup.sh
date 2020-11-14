#!/bin/bash

set -x

mkdir -p /var/lib/postgresql/data/backups
chmod 700 /var/lib/postgresql/data/backups
cd /var/lib/postgresql/data/backups

# Delete old backups; we don't need that many because we have daily
# offsite backups
ls -1rt | head -n -40 | xargs rm -f -v

for database in $(psql -q -t -c 'select datname from pg_database;' | grep -v template0)
do
  DATESTR=$(TZ=America/Los_Angeles date +%Y-%m-%d)

  echo "Backing up PostgreSQL database $database"
  /usr/bin/pg_dump -C -Fc $database -f /var/lib/postgresql/data/backups/$database.$DATESTR

  echo "Optimizing PostgreSQL database $database"
  psql -t -d $database -c 'vacuum full analyze;'
  psql -t -d $database -c "reindex database $database;"
done
