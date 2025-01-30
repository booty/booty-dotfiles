function dnsflush() {
  sudo killall -HUP mDNSResponder
  sudo dscacheutil -flushcache
}

function relaunch_firefox() {
  # Attempt to kill Firefox and capture the exit code
  sudo killall firefox 2>/dev/null
  if [[ $? -ne 0 ]]; then
    # Exit silently if no matching process is found
    return
  fi

  # Wait for Firefox to fully terminate
  while pgrep -x "firefox" >/dev/null; do
    sleep 1  # Check every second
  done

  # Retry logic for opening Firefox
  local max_retries=5
  local retry_interval=2  # Time in seconds between retries
  local attempt=0

  while (( attempt < max_retries )); do
    if open -a Firefox; then
      # Exit the loop if Firefox opens successfully
      return
    fi
    # Increment the attempt count and wait before retrying
    ((attempt++))
    sleep $retry_interval
  done

  echo "Failed to open Firefox after $max_retries attempts."
}

# if the contents of src are equal to the contents of /etc/hosts, print a message that says "ok". if the contents are inequal, replace /etc/hosts with src and print a message that says "updated hosts file"
function update_hosts_and_relaunch_firefox() {
  if [ "$(cat $1)" = "$(cat /etc/hosts)" ]; then
    echo "Hosts file seems ok already!"
    dnsflush
  else
    sudo cp -f "$1" /etc/hosts
    dnsflush
    echo "Updated hosts file. Killing Discord; killing and relaunching Firefox."
    # Firefox will cache DNS lookups
    # killall Firefox && open -a Firefox
    # pkill Discord
    # open -a Firefox
    relaunch_firefox
  fi
}

# copy ./worktime/hosts-worktime to /etc/hosts, forcing an overwrite
function worktime() {
  echo "Getting ready to work...?"
  update_hosts_and_relaunch_firefox "$HOME/booty-dotfiles/functions/worktime/hosts-worktime"
  # nohup ruby ~/booty-dotfiles/functions/worktime/worktime-webrick.rb >/dev/null 2>&1 &
  echo "Kick some ass! 💪"
}

function funtime() {
  echo "Work is over! Or... is it?"
  # `pkill -f worktime-webrick.rb`
  update_hosts_and_relaunch_firefox "$HOME/booty-dotfiles/functions/worktime/hosts-funtime"
  echo "OK, relax and browse the web."
}
