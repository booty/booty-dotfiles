# ░░░░░░░░░█▀█░█░█░▀█▀░█░█░█▀█░█▀█░░░░░░░░░░
# ░░░░░░░░░█▀▀░░█░░░█░░█▀█░█░█░█░█░░░░░░░░░░
# ░░░░░░░░░▀░░░░▀░░░▀░░▀░▀░▀▀▀░▀░▀░░░░░░░░░░

# Virtualenvs
alias va="source venv/bin/activate"
alias vd="deactivate"

# iPython
alias ip="ipython"
alias ipp="ipython -i"
# Alembic
# alias ale.nuke="alembic downgrade base && alembic upgrade head"
alias ale.redo="alembic downgrade -1 && alembic upgrade head"
alias ale.down="alembic downgrade -1"
alias ale.up="alembic upgrade head"

# Good for running a single pytest
alias pyt='ic && ENV=test pytest -vv'
