// RUN: mlir-opt -legalize-std-for-spirv %s -o - | FileCheck %s

module {

//===----------------------------------------------------------------------===//
// std.subview
//===----------------------------------------------------------------------===//

// CHECK-LABEL: @fold_static_stride_subview
// CHECK-SAME: %[[ARG0:[a-zA-Z0-9_]*]]: memref<12x32xf32>
// CHECK-SAME: %[[ARG1:[a-zA-Z0-9_]*]]: index
// CHECK-SAME: %[[ARG2:[a-zA-Z0-9_]*]]: index
// CHECK-SAME: %[[ARG3:[a-zA-Z0-9_]*]]: index
// CHECK-SAME: %[[ARG4:[a-zA-Z0-9_]*]]: index
func @fold_static_stride_subview
       (%arg0 : memref<12x32xf32>, %arg1 : index,
        %arg2 : index, %arg3 : index, %arg4 : index) {
  // CHECK: %[[C2:.*]] = constant 2
  // CHECK: %[[C3:.*]] = constant 3
  // CHECK: %[[T0:.*]] = muli %[[ARG3]], %[[C2]]
  // CHECK: %[[T1:.*]] = addi %[[ARG1]], %[[T0]]
  // CHECK: %[[T2:.*]] = muli %[[ARG4]], %[[C3]]
  // CHECK: %[[T3:.*]] = addi %[[ARG2]], %[[T2]]
  // CHECK: %[[LOADVAL:.*]] = load %[[ARG0]][%[[T1]], %[[T3]]]
  // CHECK: %[[STOREVAL:.*]] = sqrt %[[LOADVAL]]
  // CHECK: %[[T6:.*]] = muli %[[ARG3]], %[[C2]]
  // CHECK: %[[T7:.*]] = addi %[[ARG1]], %[[T6]]
  // CHECK: %[[T8:.*]] = muli %[[ARG4]], %[[C3]]
  // CHECK: %[[T9:.*]] = addi %[[ARG2]], %[[T8]]
  // CHECK store %[[STOREVAL]], %[[ARG0]][%[[T7]], %[[T9]]]
  %0 = subview %arg0[%arg1, %arg2][][] : memref<12x32xf32> to memref<4x4xf32, offset:?, strides: [64, 3]>
  %1 = load %0[%arg3, %arg4] : memref<4x4xf32, offset:?, strides: [64, 3]>
  %2 = sqrt %1 : f32
  store %2, %0[%arg3, %arg4] : memref<4x4xf32, offset:?, strides: [64, 3]>
  return
}

} // end module
