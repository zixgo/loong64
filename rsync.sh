#!/bin/bash
# Copyright 2023 zixianwei
# Use of this source code is governed by a MIT-style license that can be
# found in the LICENSE file.
#
# Usage: bash rsync.sh [h2g|g2h] <object>
#   h2g -- host to guest
#   g2h -- guest to host
#   object -- relative path or file name (absolute path is invalid.)

if [ $# -ne 2 ]; then
  echo "Usage: bash rsync.sh [h2g|g2h] <object>"
  exit 1
fi

opt=$1
obj=$2

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${SCRIPT_DIR}/loongnix.sh"

ssh_options="\
  -o UserKnownHostsFile=/dev/null
  -o StrictHostKeyChecking=no
"

function rsync_forward() {
  sshpass \
    -p \
    $vm_password \
    rsync \
    -avz --progress \
    -e "ssh $ssh_options -p $vm_fwdport" \
    $(pwd)/$obj \
    $vm_username@$vm_address:/home/$vm_username
}

function rsync_backward() {
  sshpass \
    -p \
    $vm_password \
    rsync \
    -avz --progress \
    -e "ssh $ssh_options -p $vm_fwdport" \
    $vm_username@$vm_address:/home/$vm_username/$obj \
    $(pwd)
}


if [ "$opt" == "h2g" ]; then
  rsync_forward
elif [ "$opt" == "g2h" ]; then
  rsync_backward
else
  echo "Unknown operation: [$opt]"
  exit 1
fi
