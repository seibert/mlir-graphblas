//===- GraphBLASOps.h - GraphBLAS dialect ops -----------------*- C++ -*-===//
//
// TODO add doc string
//
//===--------------------------------------------------------------------===//

#ifndef GRAPHBLAS_GRAPHBLASOPS_H
#define GRAPHBLAS_GRAPHBLASOPS_H

#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/Dialect.h"
#include "mlir/IR/OpDefinition.h"
#include "mlir/Interfaces/SideEffectInterfaces.h"

#define GET_OP_CLASSES
#include "GraphBLAS/GraphBLASOps.h.inc"

#endif // GRAPHBLAS_GRAPHBLASOPS_H
