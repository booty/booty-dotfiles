# if the contents of src are equal to the contents of /etc/hosts, print a message that says "ok". if the contents are inequal, replace /etc/hosts with src and print a message that says "updated hosts file"
function update_hosts_and_relaunch_firefox() {
  if [ "$(cat $1)" = "$(cat /etc/hosts)" ]; then
    echo "hosts file seems ok already!"
  else
    sudo cp -f "$1" /etc/hosts
    sudo killall -HUP mDNSResponder
    echo "updated hosts file"
  fi
  # Only flush DNS cache if necessary
  pkill Firefox
  open -a Firefox
}

# copy ./worktime/hosts-worktime to /etc/hosts, forcing an overwrite
function worktime() {
  echo "Getting ready to work...?"
  update_hosts_and_relaunch_firefox "$HOME/booty-dotfiles/functions/worktime/hosts-worktime"
  nohup ruby ~/booty-dotfiles/functions/worktime/worktime-webrick.rb >/dev/null 2>&1 &
  echo "Worktime hosts file installed - kick some ass."
}

function funtime() {
  echo "Work is over! Or... is it?"
  `pkill -f worktime-webrick.rb`
  update_hosts_and_relaunch_firefox "$HOME/booty-dotfiles/functions/worktime/hosts-funtime"
  echo "OK, relax and browse the web."
}
