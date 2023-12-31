# Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
# See https://llvm.org/LICENSE.txt for license information.
# SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

from ipykernel.kernelapp import IPKernelApp
from .kernel import MlirOptKernel

IPKernelApp.launch_instance(kernel_class=MlirOptKernel)
