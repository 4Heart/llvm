; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc --mtriple=loongarch64 --mattr=+lsx < %s | FileCheck %s

declare <16 x i8> @llvm.loongarch.lsx.vsub.b(<16 x i8>, <16 x i8>)

define <16 x i8> @lsx_vsub_b(<16 x i8> %va, <16 x i8> %vb) nounwind {
; CHECK-LABEL: lsx_vsub_b:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsub.b $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <16 x i8> @llvm.loongarch.lsx.vsub.b(<16 x i8> %va, <16 x i8> %vb)
  ret <16 x i8> %res
}

declare <8 x i16> @llvm.loongarch.lsx.vsub.h(<8 x i16>, <8 x i16>)

define <8 x i16> @lsx_vsub_h(<8 x i16> %va, <8 x i16> %vb) nounwind {
; CHECK-LABEL: lsx_vsub_h:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsub.h $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <8 x i16> @llvm.loongarch.lsx.vsub.h(<8 x i16> %va, <8 x i16> %vb)
  ret <8 x i16> %res
}

declare <4 x i32> @llvm.loongarch.lsx.vsub.w(<4 x i32>, <4 x i32>)

define <4 x i32> @lsx_vsub_w(<4 x i32> %va, <4 x i32> %vb) nounwind {
; CHECK-LABEL: lsx_vsub_w:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsub.w $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <4 x i32> @llvm.loongarch.lsx.vsub.w(<4 x i32> %va, <4 x i32> %vb)
  ret <4 x i32> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vsub.d(<2 x i64>, <2 x i64>)

define <2 x i64> @lsx_vsub_d(<2 x i64> %va, <2 x i64> %vb) nounwind {
; CHECK-LABEL: lsx_vsub_d:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsub.d $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vsub.d(<2 x i64> %va, <2 x i64> %vb)
  ret <2 x i64> %res
}

declare <2 x i64> @llvm.loongarch.lsx.vsub.q(<2 x i64>, <2 x i64>)

define <2 x i64> @lsx_vsub_q(<2 x i64> %va, <2 x i64> %vb) nounwind {
; CHECK-LABEL: lsx_vsub_q:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    vsub.q $vr0, $vr0, $vr1
; CHECK-NEXT:    ret
entry:
  %res = call <2 x i64> @llvm.loongarch.lsx.vsub.q(<2 x i64> %va, <2 x i64> %vb)
  ret <2 x i64> %res
}
