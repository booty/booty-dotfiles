# copy ./worktime/hosts-worktime to /etc/hosts, forcing an overwrite
function worktime() {
  echo "Getting ready to work..."
  pkill firefox
  sudo cp -f "$HOME/booty-dotfiles/functions/worktime/hosts-worktime" /etc/hosts
  sudo killall -HUP mDNSResponder
  open -a Firefox
  echo "Worktime hosts file installed - kick some ass."
}

function funtime() {
  echo "Work is over! Or... is it?"
  pkill firefox
  sudo cp -f "$HOME/booty-dotfiles/functions/worktime/hosts-funtime" /etc/hosts
  sudo killall -HUP mDNSResponder
  open -a Firefox
  echo "OK, relax and browse the web."
}
