-module(lanyard_test_ffi).
-export([to_string/1]).

to_string(Bin) when is_binary(Bin) ->
    case unicode:characters_to_binary(Bin, utf8, utf8) of
        Result when is_binary(Result) -> Result
    end.
