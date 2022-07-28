
require "./expression"
require "../tokentype"


module Pratt
  # A prefix unary arithmetic expression like "!a" or "-b".
  class PrefixExpression
    include Expression
    include TokenType

    def initialize(@m_operator : TokenType::Type, @m_right : Expression)
    end

    def print() : String
      return "(#{punctuator(@m_operator)}#{@m_right.print})"
    end
  end
end

