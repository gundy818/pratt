
require "./expression"
require "../tokentype"


module Pratt
  # A prefix unary arithmetic expression like "!a" or "-b".
  class PrefixExpression
    include Expression
    include TokenType

    def initialize(@mOperator : TokenType::Type, @mRight : Expression)
    end

    def print() : String
      return "(#{punctuator(@mOperator)}#{@mRight.print})"
    end
  end
end

