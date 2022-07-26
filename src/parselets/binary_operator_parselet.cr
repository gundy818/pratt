
require "../parser"
require "../precedence"
require "../token"
require "../expressions/expression"
require "../expressions/operator_expression"


module Pratt
  # Generic infix parselet for a binary arithmetic operator. The only difference when
  # parsing, "+", "-", "*", "/", and "^" is precedence and associativity, so we can use
  # a single parselet class for all of those.
  class BinaryOperatorParselet
    include InfixParselet

    getter mPrecedence : Precedence

    def initialize(@mPrecedence, @mIsRight : Bool)
    end

    def parse(parser : Parser, left : Expression, token : Token) : Expression
      # To handle right-associative operators like "^", we allow a slightly
      # lower precedence when parsing the right-hand side. This will let a
      # parselet with the same precedence appear on the right, which will then
      # take *this* parselet's result as its left-hand argument.
      right = parser.parseExpression(@mPrecedence - (@mIsRight ? 1 : 0))

      return OperatorExpression.new(left, token.mType, right)
    end
  end
end

