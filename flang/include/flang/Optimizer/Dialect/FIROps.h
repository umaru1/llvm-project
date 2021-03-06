//===-- Optimizer/Dialect/FIROps.h - FIR operations -------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef OPTIMIZER_DIALECT_FIROPS_H
#define OPTIMIZER_DIALECT_FIROPS_H

#include "mlir/Dialect/StandardOps/IR/Ops.h"
#include "mlir/Interfaces/LoopLikeInterface.h"
#include "mlir/Interfaces/SideEffects.h"

using namespace mlir;

namespace fir {

class FirEndOp;
class LoopOp;
class RealAttr;

void buildCmpFOp(mlir::Builder *builder, mlir::OperationState &result,
                 mlir::CmpFPredicate predicate, mlir::Value lhs,
                 mlir::Value rhs);
void buildCmpCOp(mlir::Builder *builder, mlir::OperationState &result,
                 mlir::CmpFPredicate predicate, mlir::Value lhs,
                 mlir::Value rhs);
unsigned getCaseArgumentOffset(llvm::ArrayRef<mlir::Attribute> cases,
                               unsigned dest);
LoopOp getForInductionVarOwner(mlir::Value val);
bool isReferenceLike(mlir::Type type);
mlir::ParseResult isValidCaseAttr(mlir::Attribute attr);
mlir::ParseResult parseCmpfOp(mlir::OpAsmParser &parser,
                              mlir::OperationState &result);
mlir::ParseResult parseCmpcOp(mlir::OpAsmParser &parser,
                              mlir::OperationState &result);
mlir::ParseResult parseSelector(mlir::OpAsmParser &parser,
                                mlir::OperationState &result,
                                mlir::OpAsmParser::OperandType &selector,
                                mlir::Type &type);

#define GET_OP_CLASSES
#include "flang/Optimizer/Dialect/FIROps.h.inc"

} // namespace fir

#endif // OPTIMIZER_DIALECT_FIROPS_H
