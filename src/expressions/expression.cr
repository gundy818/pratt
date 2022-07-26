
module Pratt
  # Interface for all expression AST node classes.
  module Expression
    # Pretty-print the expression to a string. */
    abstract def print() : String
  end
end

