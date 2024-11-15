# ░░░░░░░█▀█░█░░░█▀▀░█▄█░█▀▄░▀█▀░█▀▀░░░░░░
# ░░░░░░░█▀█░█░░░█▀▀░█░█░█▀▄░░█░░█░░░░░░░░
# ░░░░░░░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀▀▀░░░░░░

alias ale.redo="alembic downgrade -1 && alembic upgrade head"
alias ale.down="alembic downgrade -1"
alias ale.up="alembic upgrade head"

ale.rev() {
    alembic revision -m "$1"
}

ale.auto() {
    alembic revision --autogenerate -m "$1"
}
