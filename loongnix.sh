# Copyright 2023 zixianwei
# Use of this source code is governed by a MIT-style license that can be
# found in the LICENSE file.
#
# This script should not be run directly but sourced by the other
# scripts (e.g. launch.sh).

bios_file=${SCRIPT_DIR}/QEMU_EFI.fd
qcow_file=${SCRIPT_DIR}/Loongnix-20.3.mate.mini.loongarch64.en.qcow2
vm_username=loongson
vm_password=Loongson20
vm_address=127.0.0.1
vm_fwdport=22222
