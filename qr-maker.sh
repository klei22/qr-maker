#!/bin/bash

# handle cleanup for temp file
trap cleanup_on_sigint SIGINT SIGTERM

# cleanup in case of sigint
cleanup_on_sigint() {
  echo -e "\ncleaning tmp/qr-maker-temp-$$.png"
  rm /tmp/qr-maker-temp-$$.png
  trap - SIGINT SIGTERM # sig term too for good measure
  echo "clean up complete"
  kill -- -$$ # kill current process
}


# message to encode
message=$1


# encode message
qrencode -o /tmp/qr-maker-temp-$$.png "$message"

# print message
lpr /tmp/qr-maker-temp-$$.png
