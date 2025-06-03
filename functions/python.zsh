# ░░░░░░░░░█▀█░█░█░▀█▀░█░█░█▀█░█▀█░░░░░░░░░░
# ░░░░░░░░░█▀▀░░█░░░█░░█▀█░█░█░█░█░░░░░░░░░░
# ░░░░░░░░░▀░░░░▀░░░▀░░▀░▀░▀▀▀░▀░▀░░░░░░░░░░

# Virtualenvs
alias venv="python3 -m venv venv"
va() {
    if ! source venv/bin/activate 2>/dev/null; then
        source .venv/bin/activate 2>/dev/null || echo "Failed to activate virtual environment."
    fi
}
alias da="deactivate"

# iPython
alias ip="ipython"
alias ipp="ipython -i"
alias ipy="ipython -i -c 'import sys; sys.path.append(\".\")'"

alias py="python"
alias pym="python -m"

# Good for running a single pytest
alias pyt='ic && ENV=test pytest -vv'

alias py.top_level_deps="pip list --not-required --format=freeze"
