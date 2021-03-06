#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

if ! dcos --version 2>/dev/null; then
  echo "Install a dcos cli!"
  exit 1
fi

# setup kafka
echo "Installing data_generator service"
if ! dcos node > /dev/null 2<&1; then
    dcos auth login
fi

dcos marathon app add service-generator.json

echo "--> wait 30 seconds"
sleep 30

# verify deployment status
dcos marathon app list
