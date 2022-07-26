
require "../tokentype"
require "./expression"


module Pratt
  # A binary arithmetic expression like "a + b" or "c ^ d".
  class OperatorExpression
    include Expression
  include TokenType

    def initialize(@mLeft : Expression, @mOperator : Type, @mRight : Expression)
    end

    def print() : String
      return "(#{@mLeft.print} #{punctuator(@mOperator)} #{@mRight.print})"
    end
  end
end

