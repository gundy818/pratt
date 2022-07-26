
require "./expression"

module Pratt

  # An assignment expression like "a = b".
  class AssignExpression
    include Expression

    def initialize(@mName : String, @mRight : Expression)
    end

    def print() : String
      return "(#{@mName} = #{@mRight.print})"
    end
  end
end

