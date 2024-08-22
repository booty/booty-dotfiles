
# declare a variable called eza_defaults
export eza_defaults="--long --color=always --group-directories-first --sort=name --time-style=long-iso"


alias ls.dirs="eza --only-dirs $eza_defaults"
alias ls.files="eza $eza_defaults | grep -v /"
alias ls.tree1="eza --tree --level=2 $eza_defaults"
alias ls.tree2="eza --tree --level=3 $eza_defaults"
alias ls.tree3="eza --tree --level=4 $eza_defaults"
alias ls.dtree1="eza --tree --level=2 --only-dirs $eza_defaults"
alias ls.dtree2="eza --tree --level=3 --only-dirs $eza_defaults"
alias ls.dtree3="eza --tree --level=4 --only-dirs $eza_defaults"
alias ls.newest="eza $eza_defaults --sort=modified"
alias ls.biggest="eza $eza_defaults --sort=size"
