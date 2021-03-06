// RUN: graphblas-opt %s | graphblas-opt --graphblas-lower | FileCheck %s

#CSR64 = #sparse_tensor.encoding<{
  dimLevelType = [ "dense", "compressed" ],
  dimOrdering = affine_map<(i,j) -> (i,j)>,
  pointerBitWidth = 64,
  indexBitWidth = 64
}>

#CSC64 = #sparse_tensor.encoding<{
  dimLevelType = [ "dense", "compressed" ],
  dimOrdering = affine_map<(i,j) -> (j,i)>,
  pointerBitWidth = 64,
  indexBitWidth = 64
}>


// look for inlined addition of 4.0 to total

// CHECK:           %[[VAL_6:.*]] = constant 4.000000e+00 : f64
// CHECK:                 %[[VAL_107:.*]] = scf.if %[[VAL_108:.*]]#1 -> (index) {
// CHECK:                   %[[VAL_109:.*]] = addi %[[VAL_74:.*]], %[[VAL_87:.*]] : index
// CHECK:                   memref.store %[[VAL_88:.*]], %[[VAL_66:.*]]{{\[}}%[[VAL_109]]] : memref<?xi64>
// CHECK:                   %[[VAL_2000:.*]] = addf %[[VAL_108]]#0, %[[VAL_6]] : f64
// CHECK:                   memref.store %[[VAL_2000]], %[[VAL_67:.*]]{{\[}}%[[VAL_109]]] : memref<?xf64>

func @matrix_multiply_plus_times(%a: tensor<?x?xf64, #CSR64>, %b: tensor<?x?xf64, #CSC64>) -> tensor<?x?xf64, #CSR64> {
    %cf4 = constant 4.0 : f64

    %answer = graphblas.matrix_multiply %a, %b { semiring = "plus_times" } : (tensor<?x?xf64, #CSR64>, tensor<?x?xf64, #CSC64>) to tensor<?x?xf64, #CSR64> {
        ^bb0(%value: f64):
            %result = std.addf %value, %cf4: f64
            graphblas.yield %result : f64
    }
    return %answer : tensor<?x?xf64, #CSR64>
}
