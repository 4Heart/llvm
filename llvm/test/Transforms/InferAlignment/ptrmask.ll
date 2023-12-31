; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt < %s -passes=infer-alignment -S | FileCheck %s

; ------------------------------------------------------------------------------
; load instructions
; ------------------------------------------------------------------------------

define void @load(ptr align 1 %ptr) {
; CHECK-LABEL: define void @load
; CHECK-SAME: (ptr align 1 [[PTR:%.*]]) {
; CHECK-NEXT:    [[ALIGNED_0:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[PTR]], i64 -2)
; CHECK-NEXT:    [[ALIGNED_1:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[PTR]], i64 -4)
; CHECK-NEXT:    [[ALIGNED_2:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[PTR]], i64 -8)
; CHECK-NEXT:    [[LOAD_0:%.*]] = load <16 x i8>, ptr [[ALIGNED_0]], align 2
; CHECK-NEXT:    [[LOAD_1:%.*]] = load <16 x i8>, ptr [[ALIGNED_1]], align 4
; CHECK-NEXT:    [[LOAD_2:%.*]] = load <16 x i8>, ptr [[ALIGNED_2]], align 8
; CHECK-NEXT:    ret void
;
  %aligned.0 = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 -2)
  %aligned.1 = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 -4)
  %aligned.2 = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 -8)

  %load.0 = load <16 x i8>, ptr %aligned.0, align 1
  %load.1 = load <16 x i8>, ptr %aligned.1, align 1
  %load.2 = load <16 x i8>, ptr %aligned.2, align 1

  ret void
}

; ------------------------------------------------------------------------------
; store instructions
; ------------------------------------------------------------------------------

define void @store(ptr align 1 %ptr) {
; CHECK-LABEL: define void @store
; CHECK-SAME: (ptr align 1 [[PTR:%.*]]) {
; CHECK-NEXT:    [[ALIGNED_0:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[PTR]], i64 -2)
; CHECK-NEXT:    [[ALIGNED_1:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[PTR]], i64 -4)
; CHECK-NEXT:    [[ALIGNED_2:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[PTR]], i64 -8)
; CHECK-NEXT:    store <16 x i8> zeroinitializer, ptr [[ALIGNED_0]], align 2
; CHECK-NEXT:    store <16 x i8> zeroinitializer, ptr [[ALIGNED_1]], align 4
; CHECK-NEXT:    store <16 x i8> zeroinitializer, ptr [[ALIGNED_2]], align 8
; CHECK-NEXT:    ret void
;
  %aligned.0 = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 -2)
  %aligned.1 = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 -4)
  %aligned.2 = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 -8)

  store <16 x i8> zeroinitializer, ptr %aligned.0, align 1
  store <16 x i8> zeroinitializer, ptr %aligned.1, align 1
  store <16 x i8> zeroinitializer, ptr %aligned.2, align 1

  ret void
}

; ------------------------------------------------------------------------------
; Overaligned pointer
; ------------------------------------------------------------------------------

; Underlying alignment greater than alignment forced by ptrmask
define void @ptrmask_overaligned(ptr align 16 %ptr) {
; CHECK-LABEL: define void @ptrmask_overaligned
; CHECK-SAME: (ptr align 16 [[PTR:%.*]]) {
; CHECK-NEXT:    [[ALIGNED:%.*]] = call ptr @llvm.ptrmask.p0.i64(ptr [[PTR]], i64 -8)
; CHECK-NEXT:    [[LOAD:%.*]] = load <16 x i8>, ptr [[ALIGNED]], align 16
; CHECK-NEXT:    store <16 x i8> zeroinitializer, ptr [[ALIGNED]], align 16
; CHECK-NEXT:    ret void
;
  %aligned = call ptr @llvm.ptrmask.p0.i64(ptr %ptr, i64 -8)

  %load = load <16 x i8>, ptr %aligned, align 1
  store <16 x i8> zeroinitializer, ptr %aligned, align 1

  ret void
}

declare ptr @llvm.ptrmask.p0.i64(ptr, i64)
