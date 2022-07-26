
require "../parser"
require "../token"
require "../expressions/expression"


module Pratt

  # One of the two parselet interfaces used by the Pratt parser. An
  # InfixParselet is associated with a token that appears in the middle of the
  # expression it parses. Its parse() method will be called after the left-hand
  # side has been parsed, and it in turn is responsible for parsing everything
  # that comes after the token. This is also used for postfix expressions, in
  # which case it simply doesn't consume any more tokens in its parse() call.

  module InfixParselet
    abstract def parse(parser : Parser, left : Expression, token : Token) : Expression
  end
end

