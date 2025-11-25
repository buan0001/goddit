set shell := ["bash", "-uc"]

default:
  just --list

run:
    docker compose up

rebuild:
    docker compose up --build

migrator:
    docker compose -f migrator/compose.yaml up --build

down:
    docker compose down