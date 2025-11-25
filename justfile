# set shell := ["bash", "-uc"]

# set env {
#     PATH = "/usr/local/go/bin:{env.PATH}"
# }

debug:
    go version

default:
  just --list

run:
    docker compose up

build-app:
    cd backend && go build -o app .

rebuild:
    docker compose up --build

migrator:
    docker compose -f migrator/compose.yaml up --build

down:
    docker compose down