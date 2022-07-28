
require "./expression"
require "../tokentype"


module Pratt
  # A postfix unary arithmetic expression like "a!".
  class PostfixExpression
    include Expression
    include TokenType

    def initialize(@m_left : Expression, @m_operator : Type)
    end

    def print() : String
      return "(#{@m_left.print}#{punctuator(@m_operator)})"
    end
  end
end

