// REQUIRES: x86-registered-target

// RUN: rm -rf %t; mkdir %t
// RUN: %clang -target x86_64-apple-macos11.0 -c %s -o %t/x86_64.o -femit-compact-unwind-non-canonical
// RUN: %clang -target x86_64-apple-macos11.0 -femit-dwarf-unwind=no-compact-unwind -c %s -o %t/x86_64-no-dwarf.o -femit-compact-unwind-non-canonical
// RUN: llvm-objdump --macho --dwarf=frames %t/x86_64.o | FileCheck %s --check-prefix=WITH-FDE
// RUN: llvm-objdump --macho --dwarf=frames %t/x86_64-no-dwarf.o | FileCheck %s --check-prefix=NO-FDE

// WITH-FDE: FDE
// NO-FDE-NOT: FDE

.text
_foo:
  .cfi_startproc
  .cfi_def_cfa_offset 8
  ret
  .cfi_endproc
