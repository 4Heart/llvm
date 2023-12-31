# NOTE: Assertions have been autogenerated by utils/update_mca_test_checks.py
# RUN: llvm-mca -mtriple=x86_64-unknown-unknown -mcpu=btver2 -timeline -timeline-max-iterations=2 < %s | FileCheck %s

# VALU0/VALU1
vpmulld     %xmm0, %xmm1, %xmm2
vpand       %xmm0, %xmm1, %xmm2

# VIMUL/STC
vcvttps2dq  %xmm0, %xmm2
vpclmulqdq  $0, %xmm0, %xmm1, %xmm2

# FPA/FPM
vaddps      %xmm0, %xmm1, %xmm2
vsqrtps     %xmm0, %xmm2

# FPA/FPM YMM
vaddps      %ymm0, %ymm1, %ymm2
vsqrtps     %ymm0, %ymm2

# CHECK:      Iterations:        100
# CHECK-NEXT: Instructions:      800
# CHECK-NEXT: Total Cycles:      6306
# CHECK-NEXT: Total uOps:        1200

# CHECK:      Dispatch Width:    2
# CHECK-NEXT: uOps Per Cycle:    0.19
# CHECK-NEXT: IPC:               0.13
# CHECK-NEXT: Block RThroughput: 63.0

# CHECK:      Instruction Info:
# CHECK-NEXT: [1]: #uOps
# CHECK-NEXT: [2]: Latency
# CHECK-NEXT: [3]: RThroughput
# CHECK-NEXT: [4]: MayLoad
# CHECK-NEXT: [5]: MayStore
# CHECK-NEXT: [6]: HasSideEffects (U)

# CHECK:      [1]    [2]    [3]    [4]    [5]    [6]    Instructions:
# CHECK-NEXT:  3      4     2.00                        vpmulld	%xmm0, %xmm1, %xmm2
# CHECK-NEXT:  1      1     0.50                        vpand	%xmm0, %xmm1, %xmm2
# CHECK-NEXT:  1      3     1.00                        vcvttps2dq	%xmm0, %xmm2
# CHECK-NEXT:  1      2     1.00                        vpclmulqdq	$0, %xmm0, %xmm1, %xmm2
# CHECK-NEXT:  1      3     1.00                        vaddps	%xmm0, %xmm1, %xmm2
# CHECK-NEXT:  1      21    21.00                       vsqrtps	%xmm0, %xmm2
# CHECK-NEXT:  2      3     2.00                        vaddps	%ymm0, %ymm1, %ymm2
# CHECK-NEXT:  2      42    42.00                       vsqrtps	%ymm0, %ymm2

# CHECK:      Resources:
# CHECK-NEXT: [0]   - JALU0
# CHECK-NEXT: [1]   - JALU1
# CHECK-NEXT: [2]   - JDiv
# CHECK-NEXT: [3]   - JFPA
# CHECK-NEXT: [4]   - JFPM
# CHECK-NEXT: [5]   - JFPU0
# CHECK-NEXT: [6]   - JFPU1
# CHECK-NEXT: [7]   - JLAGU
# CHECK-NEXT: [8]   - JMul
# CHECK-NEXT: [9]   - JSAGU
# CHECK-NEXT: [10]  - JSTC
# CHECK-NEXT: [11]  - JVALU0
# CHECK-NEXT: [12]  - JVALU1
# CHECK-NEXT: [13]  - JVIMUL

# CHECK:      Resource pressure per iteration:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]
# CHECK-NEXT:  -      -      -     3.00   63.00  6.01   5.99    -      -      -     1.00   1.00   1.00   3.00

# CHECK:      Resource pressure by instruction:
# CHECK-NEXT: [0]    [1]    [2]    [3]    [4]    [5]    [6]    [7]    [8]    [9]    [10]   [11]   [12]   [13]   Instructions:
# CHECK-NEXT:  -      -      -      -      -     2.00   1.00    -      -      -      -     0.02   0.98   2.00   vpmulld	%xmm0, %xmm1, %xmm2
# CHECK-NEXT:  -      -      -      -      -     0.01   0.99    -      -      -      -     0.98   0.02    -     vpand	%xmm0, %xmm1, %xmm2
# CHECK-NEXT:  -      -      -      -      -      -     1.00    -      -      -     1.00    -      -      -     vcvttps2dq	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -      -      -     1.00    -      -      -      -      -      -      -     1.00   vpclmulqdq	$0, %xmm0, %xmm1, %xmm2
# CHECK-NEXT:  -      -      -     1.00    -     1.00    -      -      -      -      -      -      -      -     vaddps	%xmm0, %xmm1, %xmm2
# CHECK-NEXT:  -      -      -      -     21.00   -     1.00    -      -      -      -      -      -      -     vsqrtps	%xmm0, %xmm2
# CHECK-NEXT:  -      -      -     2.00    -     2.00    -      -      -      -      -      -      -      -     vaddps	%ymm0, %ymm1, %ymm2
# CHECK-NEXT:  -      -      -      -     42.00   -     2.00    -      -      -      -      -      -      -     vsqrtps	%ymm0, %ymm2

# CHECK:      Timeline view:
# CHECK-NEXT:                     0123456789          0123456789          0123456789          0
# CHECK-NEXT: Index     0123456789          0123456789          0123456789          0123456789

# CHECK:      [0,0]     DeeeeER   .    .    .    .    .    .    .    .    .    .    .    .    .   vpmulld	%xmm0, %xmm1, %xmm2
# CHECK-NEXT: [0,1]     .DeE--R   .    .    .    .    .    .    .    .    .    .    .    .    .   vpand	%xmm0, %xmm1, %xmm2
# CHECK-NEXT: [0,2]     . DeeeER  .    .    .    .    .    .    .    .    .    .    .    .    .   vcvttps2dq	%xmm0, %xmm2
# CHECK-NEXT: [0,3]     . DeeE-R  .    .    .    .    .    .    .    .    .    .    .    .    .   vpclmulqdq	$0, %xmm0, %xmm1, %xmm2
# CHECK-NEXT: [0,4]     .  DeeeER .    .    .    .    .    .    .    .    .    .    .    .    .   vaddps	%xmm0, %xmm1, %xmm2
# CHECK-NEXT: [0,5]     .  DeeeeeeeeeeeeeeeeeeeeeER   .    .    .    .    .    .    .    .    .   vsqrtps	%xmm0, %xmm2
# CHECK-NEXT: [0,6]     .   DeeeE-----------------R   .    .    .    .    .    .    .    .    .   vaddps	%ymm0, %ymm1, %ymm2
# CHECK-NEXT: [0,7]     .    D===================eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeER .   vsqrtps	%ymm0, %ymm2
# CHECK-NEXT: [1,0]     .    .DeeeeE--------------------------------------------------------R .   vpmulld	%xmm0, %xmm1, %xmm2
# CHECK-NEXT: [1,1]     .    . DeE-----------------------------------------------------------R.   vpand	%xmm0, %xmm1, %xmm2
# CHECK-NEXT: [1,2]     .    .  DeeeE--------------------------------------------------------R.   vcvttps2dq	%xmm0, %xmm2
# CHECK-NEXT: [1,3]     .    .  DeeE----------------------------------------------------------R   vpclmulqdq	$0, %xmm0, %xmm1, %xmm2
# CHECK-NEXT: [1,4]     .    .   DeeeE--------------------------------------------------------R   vaddps	%xmm0, %xmm1, %xmm2
# CHECK-NEXT: Truncated display due to cycle limit

# CHECK:      Average Wait times (based on the timeline view):
# CHECK-NEXT: [0]: Executions
# CHECK-NEXT: [1]: Average time spent waiting in a scheduler's queue
# CHECK-NEXT: [2]: Average time spent waiting in a scheduler's queue while ready
# CHECK-NEXT: [3]: Average time elapsed from WB until retire stage

# CHECK:            [0]    [1]    [2]    [3]
# CHECK-NEXT: 0.     2     1.0    1.0    28.0      vpmulld	%xmm0, %xmm1, %xmm2
# CHECK-NEXT: 1.     2     1.0    1.0    30.5      vpand	%xmm0, %xmm1, %xmm2
# CHECK-NEXT: 2.     2     1.0    1.0    28.0      vcvttps2dq	%xmm0, %xmm2
# CHECK-NEXT: 3.     2     1.0    1.0    29.5      vpclmulqdq	$0, %xmm0, %xmm1, %xmm2
# CHECK-NEXT: 4.     2     1.0    1.0    28.0      vaddps	%xmm0, %xmm1, %xmm2
# CHECK-NEXT: 5.     2     29.5   29.5   0.0       vsqrtps	%xmm0, %xmm2
# CHECK-NEXT: 6.     2     1.0    1.0    45.5      vaddps	%ymm0, %ymm1, %ymm2
# CHECK-NEXT: 7.     2     48.5   48.5   0.0       vsqrtps	%ymm0, %ymm2
# CHECK-NEXT:        2     10.5   10.5   23.7      <total>
