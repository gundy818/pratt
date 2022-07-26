
require "./expression"

module Pratt
  class ConditionalExpression
    include Pratt::Expression
 
    property condition : Expression
    property thenArm : Expression
    property elseArm : Expression

    def initialize(@condition, @thenArm, @elseArm)
    end

    def print() : String
      return "(#{@condition.print()} ? #{@thenArm.print()} : #{@elseArm.print()})"
    end
  end
end

