# Copyright 2023 zixianwei
# Use of this source code is governed by a MIT-style license that can be
# found in the LICENSE file.
#
# This script should not be run directly but sourced by the other
# scripts (e.g. launch.sh).

bios_file=${SCRIPT_DIR}/QEMU_EFI.fd
qcow_file=${SCRIPT_DIR}/archlinux-mate-2022.12.03-loong64.qcow2
vm_username=loongarch
vm_password=loongarch
vm_address=127.0.0.1
vm_fwdport=22223