-module(prop_generators).

-include_lib("proper/include/proper.hrl").

-define(SPECIAL_CHARACTERS,
        [$`, $~, $!, $@, $#, $$, $%, $^, $&, $*, $(, $), $-, $+, $=, ${,
         $}, $[, $], $|, $\\, $:, $;, $", $', $<, $,, $>, $., $?, $/ ]).

-define(MIN_RANGE, 5).
-define(MAX_RANGE, 100).

-export([ normalized_string/0 ]).

normalized_string() ->
  ?LET(
    Size,
    choose(?MIN_RANGE, ?MAX_RANGE),
    non_empty(
      vector(
        Size,
        frequency([
          {25, range($a, $z)},                % Small letters.
          {25, range($A, $Z)},                % Capital letters.
          {25, oneof(?SPECIAL_CHARACTERS)},   % Punctuation.
          {25, range($0, $9)}                 % Numbers
        ])))
  ).
