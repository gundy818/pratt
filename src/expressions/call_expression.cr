
require "./expression"

module Pratt

  # A function call like "a(b, c, d)".
  class CallExpression
    include Expression

    def initialize(@mFunction : Expression, @mArgs : Array(Expression))
    end

    def print() : String
      args = @mArgs.map { |arg| arg.print }
      return "#{@mFunction.print}(#{args.join(", ")})"
    end
  end
end

