
require "../tokentype"
require "./expression"


module Pratt
  # A binary arithmetic expression like "a + b" or "c ^ d".
  class OperatorExpression
    include Expression
  include TokenType

    def initialize(@m_left : Expression, @m_operator : Type, @m_right : Expression)
    end

    def print() : String
      return "(#{@m_left.print} #{punctuator(@m_operator)} #{@m_right.print})"
    end
  end
end

