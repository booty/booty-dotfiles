# ░░░░░░░░░█▀▄░█░█░█▀▄░█░█░░░░░░░░░░
# ░░░░░░░░░█▀▄░█░█░█▀▄░░█░░░░░░░░░░░
# ░░░░░░░░░▀░▀░▀▀▀░▀▀░░░▀░░░░░░░░░░░

alias be="bundle exec"
alias ber="bundle exec ruby"
alias bi="bundle install"
alias rc="bundle exec rails console"
alias rs="bundle exec rails server"
alias rrc="bundle exec rescue rails console"
alias rrs="bundle exec rescue rails server"
alias rg="bundle exec rails generate"
alias rdbm="bundle exec rails db:migrate"
alias railtail='tail -f -n 10000 log/development.log | ag -A1 "(Started (POST|GET|PATCH|PUT|DELETE) \"\/.*\")|jbootz|(Processing by.*#.*$)|Rendered"'
alias r="rails"
alias rg="rails g"
alias rt="rails test"
alias rgm="rails generate migration"
alias rr="rails routes | ag -v \"active_storage|action_mailbox|turbo\""
alias rrr="rails routes"
alias beg="bundle exec guard"
alias ber="bundle exec rspec"
alias cber="clear; bundle exec rspec"
alias cberr="clear; bundle exec rescue rspec"
