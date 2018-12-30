#!/bin/bash

# define name for tempfile
tempfile=/tmp/qr-maker-temp-$$.png
tempfile_annotated=/tmp/qr-maker-temp-annotated-$$.png

# handle cleanup for temp file
trap cleanup_on_sigint SIGINT SIGTERM

# cleanup in case of sigint
cleanup_on_sigint() {
  echo -e "\ncleaning tmp/qr-maker-temp-$$.png"

  if [ -z "$tempfile" ]; then
    rm "$tempfile"
    echo "removed $tempfile"
  fi

  if [ -z "$tempfile_annotated" ]; then
    rm "$tempfile_annotated"
    echo "removed $tempfile_annotated"
  fi

  trap - SIGINT SIGTERM # sig term too for good measure

  echo "clean up complete"
  kill -- -$$ # kill current process
}

usage_notes() {
  echo "Usage: $0 -m <message_to_be_encoded_as_qr> [-l <plaintext_label>]"
}

while getopts "m:l:" option; do
  case "${option}" in
    m)
      m="${OPTARG}"
      if [ "$m" == "" ]; then
        usage_notes_exit
      fi
      ;;
    l)
      l="${OPTARG}"
      ;;
    *)
      usage_notes
      exit
      ;;
  esac
done

if [ "$m" != "" ]; then
  # encode message
  echo "start encode"
  qrencode -o "$tempfile" "$m" || usage_notes
else
  # if no message then exit
  usage_notes
  exit
fi

if [ "$l" != "" ]; then
  # add (optional) label
  convert "$tempfile" label:"$l" -gravity Center -append "$tempfile_annotated" || usage_notes
  lp "$tempfile_annotated" || usage_notes
else
  # no label, just print message
  lp "$tempfile" || usage_notes
fi
