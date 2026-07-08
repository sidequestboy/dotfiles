; Inject minilang language into relevant function arguments
((call_expression
  function: (identifier) @func_name
  arguments: (arguments (string (string_fragment) @minilang_code)))
 (#match? @func_name "^(sound|note|gain|lpf|vowel)$")
 (#set! injection.language "minilang"))

