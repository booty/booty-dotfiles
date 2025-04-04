# ░░░░░░░█▄█░█▀█░█▀▀░█▀▀░█▄█░█▀█░▀█▀░█▀▄░▀█▀░█░█░░░░░░
# ░░░░░░░█░█░█▀█░▀▀█░▀▀█░█░█░█▀█░░█░░█▀▄░░█░░▄▀▄░░░░░░
# ░░░░░░░▀░▀░▀░▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀░▀░▀▀▀░▀░▀░░░░░░

alias mm.pg="psql -h localhost -q -p 5423 -d mm_dev -U postgres"
alias mm.schema="pg_dump -h localhost -p 5423 -d mm_dev -U postgres --schema-only"
alias mm.s="screen -S massmatrix -c ./.screenrc"
alias mm.check="ruff check . --fix && mypy --strict-optional --check-untyped-defs --disallow-incomplete-defs --warn-unused-configs --follow-imports=normal api/ && yarn eslint ./frontend/**/*.ts && ag jbootz"
alias mm.c="mm.check"
alias mm.test="mm.check && make pytest"
alias mm.test-local="mm.check && pytest"
alias mm.t="mm.test"

alias mm.upgrade-dbs="ENV=development alembic upgrade head && ENV=test alembic upgrade head"

alias mz="cd ~/code/mzml_web && va"
alias mzml="mz"
# alias mm.pgwatch="watch -n 2 psql -h localhost -q -p 5423 -d mm_dev -U postgres -c \"select id, name, extension, hash, state from datafiles;\""

# alias mm.restart_workers="docker restart mzml_web-mm_worker-1 mzml_web-mm_worker-2 mzml_web-mm_worker-3 mzml_web-mm_worker-4"

# alias mm.restart_workers="docker restart mzml_web-mm_worker-1 &
# docker restart mzml_web-mm_worker-2 &
# docker restart mzml_web-mm_worker-3 &
# docker restart mzml_web-mm_worker-4 &"

alias mm.restartworkers="docker compose restart mm_worker mm_rmq"

alias mm.db.dev="usql postgres://postgres:postgres@localhost:5423/mm_dev"
alias mm.db.dev="usql postgres://postgres:postgres@localhost:5423/mm_test"

alias mm.tail.debug="docker compose logs -f --tail=500 mm_worker mm_api mm_db"
alias mm.tail.db="docker compose logs -f --tail=500 mm_db"
alias mm.tail.api="docker compose logs -f --tail=500 mm_api"
alias mm.tail.worker="docker compose logs -f --tail=500 mm_worker"
