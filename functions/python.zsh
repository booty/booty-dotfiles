# ░░░░░░░░░█▀█░█░█░▀█▀░█░█░█▀█░█▀█░░░░░░░░░░
# ░░░░░░░░░█▀▀░░█░░░█░░█▀█░█░█░█░█░░░░░░░░░░
# ░░░░░░░░░▀░░░░▀░░░▀░░▀░▀░▀▀▀░▀░▀░░░░░░░░░░

# Virtualenvs
alias venv="python3 -m venv venv"
alias va="source venv/bin/activate"
alias da="deactivate"

# iPython
alias ip="ipython"
alias ipp="ipython -i"

# Good for running a single pytest
alias py="python"
alias pyt='ic && ENV=test pytest -vv'

alias py.top_level_deps="pip list --not-required --format=freeze"
