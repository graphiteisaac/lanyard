# lanyard

A small, simple implementation of [NanoID](https://github.com/ai/nanoid) for Gleam, which is 100% dependency free! Not even bringing in the standard library!

Should work (and has been tested on) Erlang, JS in the browser, NodeJS 11+, Bun, and Deno.

[![Package Version](https://img.shields.io/hexpm/v/lanyard)](https://hex.pm/packages/lanyard)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/lanyard/)

```sh
gleam add lanyard@1
```
```gleam
import lanyard.{NanoID}

pub fn main() {
    let NanoID(my_new_id) = lanyard.new()
    echo my_new_id // A default, 21 character long NanoID

    let NanoID(my_short_id) = lanyard.custom_length(8)
    echo my_short_id // A shorter, 8 character long NanoID 
}
```

Further documentation can be found at <https://hexdocs.pm/lanyard>.

## Development

```sh
gleam test  # Run the tests
```
