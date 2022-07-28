
require "./expression"

module Pratt

  # A function call like "a(b, c, d)".
  class CallExpression
    include Expression

    def initialize(@m_function : Expression, @m_args : Array(Expression))
    end

    def print() : String
      args = @m_args.map(&.print)
      return "#{@m_function.print}(#{args.join(", ")})"
    end
  end
end

