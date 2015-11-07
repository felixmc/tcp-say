#!/bin/sh

SAYFILE='say.txt'
SERVER='127.0.0.1'
PORT='8124'

function get_stat() {
  stat -f '%m' $SAYFILE
}

echo "connecting to server $SERVER:$PORT.."
(nc $SERVER $PORT >> $SAYFILE && (echo 'server disconnected!') ) &


last_stat=$(get_stat)

while true
do
  current_stat=$(get_stat)
  if [[ "$last_stat" != "$current_stat" ]];
    then
    say -v Albert $(tail -n 1 $SAYFILE);
    last_stat=$current_stat;
  fi
  sleep .5;
done
