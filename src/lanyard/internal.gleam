@external(erlang, "crypto", "strong_rand_bytes")
@external(javascript, "./lanyard_ffi.mjs", "randomBytes")
pub fn do_random_bytes(size: Int) -> BitArray

@external(erlang, "lanyard_ffi", "bitwise_and")
@external(javascript, "./lanyard_ffi.mjs", "bitwiseAnd")
pub fn bitwise_and(left: Int, right: Int) -> Int
