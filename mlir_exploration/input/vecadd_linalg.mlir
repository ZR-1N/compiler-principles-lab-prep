
module {
  func.func @add(
      %a: memref<16xi16>,
      %b: memref<16xi16>,
      %c: memref<16xi16>) {
    linalg.generic {
      indexing_maps = [
        affine_map<(d0) -> (d0)>,
        affine_map<(d0) -> (d0)>,
        affine_map<(d0) -> (d0)>
      ],
      iterator_types = ["parallel"]
    }
    ins(%a, %b : memref<16xi16>, memref<16xi16>)
    outs(%c : memref<16xi16>) {
    ^bb0(%va: i16, %vb: i16, %old: i16):
      %sum = arith.addi %va, %vb : i16
      linalg.yield %sum : i16
    }
    return
  }
}

