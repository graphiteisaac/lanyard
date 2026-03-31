-module(lanyard_ffi).
-export([bitwise_and/2]).

bitwise_and(L, R) ->
  L band R.
