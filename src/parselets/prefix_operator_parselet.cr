
require "../parser"
require "../precedence"
require "../token"
require "../expressions/expression"
require "../expressions/prefix_expression"


module Pratt
  # Generic prefix parselet for an unary arithmetic operator. Parses prefix unary "-",
  # "+", "~", and "!" expressions.
  class PrefixOperatorParselet
    include PrefixParselet

    def initialize(@m_precedence : Precedence)
    end

    def parse(parser : Parser, token : Token) : Expression
      # To handle right-associative operators like "^", we allow a slightly lower
      # precedence when parsing the right-hand side. This will let a parselet with the
      # same precedence appear on the right, which will then take *this* parselet's
      # result as its left-hand argument.
      right = parser.parse_expression(@m_precedence)

      return PrefixExpression.new(token.m_type, right)
    end
  end
end

