# ░░░░░░░░░█▀█░█▀▀░▄▀▄░█░░░░░░░░░░░░
# ░░░░░░░░░█▀▀░▀▀█░█\█░█░░░░░░░░░░░░
# ░░░░░░░░░▀░░░▀▀▀░░▀\░▀▀▀░░░░░░░░░░

export PSQL_EDITOR="subl --wait"

export POSTGRES_VERSION="16"

alias pgconf="$EDITOR $HOMEBREW_PREFIX/var/postgresql@$POSTGRES_VERSION/postgresql.conf"

alias pgtail="tail -f -n 1000 ls $HOMEBREW_PREFIX/var/log/postgresql@$POSTGRES_VERSION.log"

# needed for some gems, packages e.g. pg, psycopg2like
export PATH="/usr/local/opt/postgresql@16/bin:$PATH"

# alias set_danger_color="it2setcolor preset 'Solarized Darcula'"
# alias unset_danger_color="it2setcolor preset 'Solarized Light'"
# alias psql_cfa_prod="set_danger_color && psql --host=cm-postgresql-cfa-prod.c8gkpopdiz3i.us-east-1.rds.amazonaws.com --dbname=cmate_production --username=cmcfamaster && unset_danger_color"
# alias psql_5g_prod="set_danger_color && echo 'todo' && unset_danger_color"
# alias solar="it2setcolor preset 'Solarized Light'"
