#!/bin/sh
set -e

# Para gerar um dump compativel com o comando abaixo, utilize este comando:
#   docker exec postgres pg_dump -U postgres -d db-name -F t -f /var/lib/postgresql/backup/db-name.dump

# echo "Importing dump for database: ${FARM_BASE_DB}"
# pg_restore --clean --if-exists --no-owner --no-privileges --username=$POSTGRES_USER --dbname=$FARM_BASE_DB /var/lib/postgresql/backup/farm_base.dump

# echo "Importing dump for database: ${KEYCLOAK_DB}"
# pg_restore --clean --if-exists --no-owner --no-privileges --username=$POSTGRES_USER --dbname=$KEYCLOAK_DB /var/lib/postgresql/backup/keycloak.dump

# echo "Importing dump for database: ${SCHEDULER_DB}"
# pg_restore --clean --if-exists --no-owner --no-privileges --username=$POSTGRES_USER --dbname=$SCHEDULER_DB /var/lib/postgresql/backup/scheduler.dump
