//===- graphblas-translate.cpp ---------------------------------*- C++ -*-===//
//
// This is a command line utility that translates a file from/to MLIR using one
// of the registered translations.
//
//===---------------------------------------------------------------------===//

#include "mlir/InitAllTranslations.h"
#include "mlir/Support/LogicalResult.h"
#include "mlir/Translation.h"

#include "GraphBLAS/GraphBLASDialect.h"

int main(int argc, char **argv) {
  mlir::registerAllTranslations();

  // TODO: Register graphblas translations here.

  return failed(
      mlir::mlirTranslateMain(argc, argv, "MLIR Translation Testing Tool"));
}
