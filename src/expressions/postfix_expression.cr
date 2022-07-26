
require "./expression"
require "../tokentype"


module Pratt
  # A postfix unary arithmetic expression like "a!".
  class PostfixExpression
    include Expression
    include TokenType

    def initialize(@mLeft : Expression, @mOperator : Type)
    end

    def print() : String
      return "(#{@mLeft.print}#{punctuator(@mOperator)})"
    end
  end
end

