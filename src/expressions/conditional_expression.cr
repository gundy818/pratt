
require "./expression"

module Pratt
  class ConditionalExpression
    include Pratt::Expression

    property condition : Expression
    property then_arm : Expression
    property else_arm : Expression

    def initialize(@condition, @then_arm, @else_arm)
    end

    def print() : String
      return "(#{@condition.print()} ? #{@then_arm.print()} : #{@else_arm.print()})"
    end
  end
end

