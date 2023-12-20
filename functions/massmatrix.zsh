# ░░░░░░░█▄█░█▀█░█▀▀░█▀▀░█▄█░█▀█░▀█▀░█▀▄░▀█▀░█░█░░░░░░
# ░░░░░░░█░█░█▀█░▀▀█░▀▀█░█░█░█▀█░░█░░█▀▄░░█░░▄▀▄░░░░░░
# ░░░░░░░▀░▀░▀░▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀░▀░▀▀▀░▀░▀░░░░░░

alias mm.pg="psql -h localhost -q -p 5423 -d mm_dev -U postgres"
alias mm.schema="pg_dump -h localhost -p 5423 -d mm_dev -U postgres --schema-only"
alias mm.s="screen -S massmatrix -c ./.screenrc"
alias mm.check="ruff . --fix && mypy --strict-optional --follow-imports=skip api/"
alias mm.c="mm.check"
alias mm.test="mm.check && pytest"
alias mm.t="mm.test"
alias mz="cd ~/code/mzml_web && va"
alias mzml="mz"
# alias mm.pgwatch="watch -n 2 psql -h localhost -q -p 5423 -d mm_dev -U postgres -c \"select id, name, extension, hash, state from datafiles;\""
