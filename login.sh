#!/bin/bash
# Copyright 2023 zixianwei
# Use of this source code is governed by a MIT-style license that can be
# found in the LICENSE file.

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${SCRIPT_DIR}/loongnix.sh"

sshpass \
  -p $vm_password \
  ssh \
  -o "ConnectTimeout=1" \
  -o "UserKnownHostsFile=/dev/null" \
  -o "StrictHostKeyChecking=no" \
  -p $vm_fwdport \
  $vm_username@$vm_address

