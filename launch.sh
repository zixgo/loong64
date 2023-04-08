#!/bin/bash
# Copyright 2023 zixianwei
# Use of this source code is governed by a MIT-style license that can be
# found in the LICENSE file.

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${SCRIPT_DIR}/loongnix.sh"

nohup \
  qemu-system-loongarch64 \
  -m 4G \
  -smp 4 \
  -cpu la464 \
  -machine virt \
  -device virtio-gpu-pci \
  -device nec-usb-xhci,id=xhci,addr=0x1b \
  -device usb-tablet,id=tablet,bus=xhci.0,port=1 \
  -device usb-kbd,id=keyboard,bus=xhci.0,port=2 \
  -bios $bios_file \
  -device virtio-blk-pci,drive=loongnix \
  -drive id=loongnix,file=$qcow_file,if=none \
  -net user,hostfwd=tcp::$vm_fwdport-:22 \
  -net nic \
  &
echo -e "qemu-system-loongarch64 running background. pid = [$!]"

# ssh exits with the exit status of the remote command 
# or with 255 if an error occurred.
status=255
retry=1
# in timeout stage, retry every 2 seconds.
# in other stages, such as key exchange stage, retry every 1 second.
# totol retry count is 900. about 15 minutes to 30 minutes.
MAX_RETRY_COUNT=900
while [ $status -ne 0 ]
do
sshpass \
  -p $vm_password \
  ssh \
  -o "ConnectTimeout=1" \
  -o "UserKnownHostsFile=/dev/null" \
  -o "StrictHostKeyChecking=no" \
  -p $vm_fwdport \
  $vm_username@$vm_address \
  'echo $(uname -m)'
status=$?
if [ $status -eq 0 ]; then
  echo -e "vm is ready for connection.\n"
  break
fi
if [ $retry -eq $MAX_RETRY_COUNT ]; then
  echo -e "vm is not reachable.\n"
  echo -e "maximum retry count [$MAX_RETRY_COUNT] has reached.\n"
  exit 1
fi
retry=$(($retry+1))
sleep 1
done
