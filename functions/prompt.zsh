# Function to abbreviate paths
# zsh_directory_name() {
#   local dir=$1
#   dir=${dir/#$HOME/~}          # Replace $HOME with ~
#   dir=${dir//\/code\//\/c\/}   # Replace /code/ with /c/
#   echo $dir
# }

git_info() {
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

  if [ -n "$branch" ]; then
    local dirty
    dirty=$(git diff --quiet || echo "*")
    echo "%F{blue}[$branch$dirty] "
  fi
}

# ruby_info() {
#   local foo
#   foo=$(ruby -e "puts RUBY_VERSION" 2>/dev/null)

#   if [ -n "$foo" ]; then
#     echo "%F{red}[$foo] "
#   fi
# }

# # return current python version
# python_info() {
#   local foo
#   foo=$(python -c "import sys; foo=sys.version; print(foo[:foo.find(' ')])" 2>/dev/null)

#   if [ -n "$foo" ]; then
#     echo "%F{green}[$foo] "
#   fi
# }

# battery_info() {
#   # declare two local variables, foo and bar
#   local charger_wattage battery_percent foo
#   charger_wattage=$(/usr/sbin/system_profiler SPPowerDataType | grep "Wattage" | grep -Eo '[0-9]+')
#   battery_percent=$(/usr/sbin/system_profiler SPPowerDataType | grep "State of Charge" | grep -Eo '[0-9]+')

#   echo "%F{yellow}[⚡️ $charger_wattage 🔋 $battery_percent] "
# }

# TODO: `ioreg -w 0 -f -r -c AppleSmartBattery` might be much faster than `system_profiler SPPowerDataType`
# battery_info_plus() {
#   local raw charger_wattage battery_percent battery_icon
#   raw=$(/usr/sbin/system_profiler SPPowerDataType)

#   charger_wattage=$(echo $raw | grep "Wattage" | grep -Eo '[0-9]+')
#   battery_percent=$(echo $raw | grep "State of Charge" | grep -Eo '[0-9]+')

#   if [ -z "$charger_wattage" ]; then
#     charger_wattage="--"
#   fi

#   if [ "$battery_percent" -lt 25 ]; then
#     battery_icon="🪫 " # need this extra space, for some reason
#   else
#     battery_icon="🔋"
#   fi

#   echo "%F{yellow}[⚡️ $charger_wattage $battery_icon $battery_percent] "
# }

# return the current datetime
# datetime_info() {
#   local foo
#   foo=$(date +"%Y-%m-%d %H:%M:%S")
#   echo "%F{orange}[$foo] "
# }


# This version has batt info
# function precmd {
#   RPROMPT="%F{cyan}[%~]%f $(git_info)$(battery_info_plus)"
# }

function precmd {
  RPROMPT="%F{cyan}$(git_info)"
}

setopt prompt_subst
# PS1="%#%f "
# PS1='$(zsh_directory_name $PWD) %# '
PROMPT="%~ %# %F{cyan}"
