; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 2
; RUN: llc --mtriple=loongarch64 --mattr=+lasx < %s | FileCheck %s

define void @test_u() nounwind {
; CHECK-LABEL: test_u:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    #APP
; CHECK-NEXT:    xvldi $xr0, 1
; CHECK-NEXT:    #NO_APP
; CHECK-NEXT:    ret
entry:
  %0 = tail call <4 x i64> asm sideeffect "xvldi ${0:u}, 1", "=f"()
  ret void
}
