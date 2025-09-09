#!/bin/sh

docker compose exec -T database psql -U postgres -c "SELECT 1 FROM pg_database WHERE datname = 'lacollection_db'" | grep -q 1 || docker compose exec -T database psql -U postgres -c "CREATE DATABASE lacollection_db;" && docker compose exec -T database psql -U postgres -d lacollection_db < lacollectiondb.sql

