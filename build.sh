#!/bin/bash

function die { echo "$@"; exit 1; };

if [[ $# == 0 ]]; then
  die "Usage: ${0} <branch>"
fi

BRANCH="${1}"
shift

mkdir -p "output"

cd scripts || die "Failed to cd into scripts folder";

find .  -maxdepth 1 -name '*.gradle' | while read -r z; do
  gpp -o "../output/${z}" \
    -U "#[" "]" "(" "," ")]" "(" ")" "#" "" \
    -M "#" "\n" " " " " "\n" "(" ")" \
    -D "MODUTILS_VERSION=${BRANCH}" \
    +ssss "'''" "'''" "\\" +sSSS '"""' '"""' "\\" \
    +ssss "'" "'" "\\" +sSSS '"' '"' "\\" \
    --include "../build.h" \
    --nostdinc +z \
    "${z}"
  EC="$?"
  if [[ "${EC}" != "0" ]]; then
    exit "${EC}"
  fi
  
  grep 'import' "../output/${z}" > /dev/null
  EC="$?"
  if [[ "${EC}" == "0" ]]; then
    grep -n 'import' "../output/${z}"
    echo ""
    echo "Imports are not allowed in ${z}"
    exit 1
  fi
  
  grep '#\[' "../output/${z}" > /dev/null
  EC="$?"
  if [[ "${EC}" == "0" ]]; then
    grep -n '#\[' "../output/${z}"
    echo ""
    echo "Unapplied macro detected in ${z}"
    exit 1
  fi
done
