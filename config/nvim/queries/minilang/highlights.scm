; Highlight numbers
((number) @number)

; Highlight brackets and operators
(["[" "]" "<" ">" "*" ","] @punctuation.special)

; Highlight identifiers (like c3, bb2, etc.)
((identifier) @variable)

