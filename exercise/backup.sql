-- Command for backup: pg_dump -U postgres -h localhost -p 5432 mydb > mydb_backup.sql

-- Create a db to restore
CREATE DATABASE IF NOT EXISTS mydb_restored;

-- Command to restore: psql -U postgres -h localhost -p 5432 mydb_restored -f mydb_backup.sql