module.exports = grammar({
  name: 'minilang',

  conflicts: $ => [
    [$._statement, $.sequence],
  ],

  extras: $ => [
    /\s/,
    $.comment,
  ],

  rules: {
    source_file: $ => repeat($._statement),

    _statement: $ => choice(
      $.pattern,
      $.sequence,
      $.operator
    ),

    pattern: $ => choice(
      seq('<', repeat($._statement), '>'),
      seq('[', repeat($._statement), ']')
    ),

    sequence: $ => repeat1(choice($.identifier, $.number, $.operator)),

    identifier: _ => /[a-zA-Z_][a-zA-Z0-9_]*/,

    number: _ => /[0-9]+(\.[0-9]+)?/,

    operator: _ => /[*:,]/,

    comment: _ => /#.*/,
  },
});

