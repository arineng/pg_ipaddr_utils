#!/usr/bin/env sh
psql -c "create extension if not exists dblink;"
psql -f pgunit-1.0/PGUnit.sql
