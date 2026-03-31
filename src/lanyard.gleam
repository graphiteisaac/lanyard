import lanyard/internal

pub type NanoID {
  NanoID(value: String)
}

const default_size = 21

/// Generate a new NanoID using the default alphabet and length.
/// The default alphabet is **A-Z** (capitals), **a-z** (lowercase),
/// **0-9**, and both **-** and **_**. The default length is **21**
pub fn new() -> NanoID {
  internal.do_random_bytes(default_size)
  |> bytes_to_id(default_size, "")
}

/// Generate a new NanoID using the default alphabet, but a custom length.
/// The default alphabet is **A-Z** (capitals), **a-z** (lowercase),
/// **0-9**, and both **-** and **_**.
///
/// If a negative length is provided, this will return a blank ID.
pub fn custom_length(size: Int) -> NanoID {
  case size < 1 {
    True -> NanoID("")
    False ->
      internal.do_random_bytes(size)
      |> bytes_to_id(size, "")
  }
}

// This may look silly, but I'm standing by it, because it's quite 
// performant and avoids using a dict (requires stdlib) and any sort 
// of manual list indexing. The perf impact would be absolutely 
// negligable, but I smiled when I thought of this, I smiled.
fn default_alphabet(idx: Int) {
  case idx {
    0 -> "A"
    1 -> "B"
    2 -> "C"
    3 -> "D"
    4 -> "E"
    5 -> "F"
    6 -> "G"
    7 -> "H"
    8 -> "I"
    9 -> "J"
    10 -> "K"
    11 -> "L"
    12 -> "M"
    13 -> "N"
    14 -> "O"
    15 -> "P"
    16 -> "Q"
    17 -> "R"
    18 -> "S"
    19 -> "T"
    20 -> "U"
    21 -> "V"
    22 -> "W"
    23 -> "X"
    24 -> "Y"
    25 -> "Z"
    26 -> "a"
    27 -> "b"
    28 -> "c"
    29 -> "d"
    30 -> "e"
    31 -> "f"
    32 -> "g"
    33 -> "h"
    34 -> "i"
    35 -> "j"
    36 -> "k"
    37 -> "l"
    38 -> "m"
    39 -> "n"
    40 -> "o"
    41 -> "p"
    42 -> "q"
    43 -> "r"
    44 -> "s"
    45 -> "t"
    46 -> "u"
    47 -> "v"
    48 -> "w"
    49 -> "x"
    50 -> "y"
    51 -> "z"
    52 -> "0"
    53 -> "1"
    54 -> "2"
    55 -> "3"
    56 -> "4"
    57 -> "5"
    58 -> "6"
    59 -> "7"
    60 -> "8"
    61 -> "9"
    62 -> "-"
    63 -> "_"

    // Crop and run back around, so we can't get an invalid state
    _ -> default_alphabet(idx % 64)
  }
}

// Turn the random assortment of bytes we've made into a string, 
// based on the default alphabet
fn bytes_to_id(bytes: BitArray, remaining: Int, accumulator: String) -> NanoID {
  case remaining, bytes {
    // We're done, return the finished output
    0, _ -> NanoID(accumulator)

    _, <<byte, rest:bits>> -> {
      let idx = internal.bitwise_and(byte, 0x3F)
      let char = default_alphabet(idx)
      bytes_to_id(rest, remaining - 1, accumulator <> char)
    }

    // Theoretically, this case should be impossible
    _, _ -> NanoID(accumulator)
  }
}
