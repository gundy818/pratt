
require "./expression"

module Pratt

  # An assignment expression like "a = b".
  class AssignExpression
    include Expression

    def initialize(@m_name : String, @m_right : Expression)
    end

    def print() : String
      return "(#{@m_name} = #{@m_right.print})"
    end
  end
end

