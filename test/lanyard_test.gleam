import gleeunit
import lanyard

pub fn main() -> Nil {
  gleeunit.main()
}

// --- Length tests ---

pub fn default_length_test() {
  assert string_length(<<lanyard.new().value:utf8>>, 0) == 21
}

pub fn custom_length_test() {
  assert string_length(<<lanyard.custom_length(10).value:utf8>>, 0) == 10
}

pub fn length_one_test() {
  // Only using A-Za-z0-9-_ so all chars are 8 bits
  let assert <<_:size(8)>> = <<lanyard.custom_length(1).value:utf8>>
}

pub fn length_large_test() {
  assert string_length(<<lanyard.custom_length(256).value:utf8>>, 0) == 256
}

pub fn length_zero_test() {
  assert lanyard.custom_length(0).value == ""
}

// -- Alphabet tests ---

const default_alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"

pub fn default_alphabet_test() {
  assert lanyard.new().value
    |> only_uses_alphabet(default_alphabet)
    == True
}

pub fn default_alphabet_repeated_test() {
  assert repeat_check(100, fn() {
      lanyard.new().value
      |> only_uses_alphabet(default_alphabet)
    })
    == True
}

// -- Uniqueness ---

pub fn uniqueness_test() {
  assert do_uniqueness_check(1000, []) == True
}

fn do_uniqueness_check(remaining: Int, seen: List(String)) -> Bool {
  case remaining {
    0 -> True
    _ -> {
      let id = lanyard.new().value
      case list_contains(seen, id) {
        True -> False
        False -> do_uniqueness_check(remaining - 1, [id, ..seen])
      }
    }
  }
}

fn list_contains(list: List(String), target: String) -> Bool {
  case list {
    [] -> False
    [head, ..rest] ->
      case head == target {
        True -> True
        False -> list_contains(rest, target)
      }
  }
}

// -- Helpers ---

fn string_length(bytes: BitArray, acc: Int) -> Int {
  case bytes {
    <<_:size(8), rest:bits>> -> string_length(rest, acc + 1)
    _ -> acc
  }
}

fn only_uses_alphabet(id: String, alphabet: String) -> Bool {
  do_only_uses_alphabet(<<id:utf8>>, <<alphabet:utf8>>)
}

fn do_only_uses_alphabet(id: BitArray, alphabet: BitArray) -> Bool {
  case id {
    <<>> -> True
    <<byte, rest:bits>> -> {
      case bit_array_contains_byte(alphabet, byte) {
        True -> do_only_uses_alphabet(rest, alphabet)
        False -> False
      }
    }
    _ -> False
  }
}

fn bit_array_contains_byte(haystack: BitArray, target: Int) -> Bool {
  case haystack {
    <<>> -> False
    <<byte, rest:bits>> ->
      case byte == target {
        True -> True
        False -> bit_array_contains_byte(rest, target)
      }
    _ -> False
  }
}

@external(erlang, "lanyard_test_ffi", "to_string")
@external(javascript, "./lanyard_test_ffi.mjs", "toString")
pub fn bit_array_to_string(bytes: BitArray) -> String

fn repeat_check(count: Int, check: fn() -> Bool) -> Bool {
  case count {
    0 -> True
    _ ->
      case check() {
        False -> False
        True -> repeat_check(count - 1, check)
      }
  }
}
