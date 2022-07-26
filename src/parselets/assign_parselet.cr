
require "../expressions/assign_expression"
require "../expressions/expression"
require "../expressions/name_expression"
require "../exceptions"
require "../parser"
require "../precedence"
require "../token"


module Pratt
    # Parses assignment expressions like "a = b". The left side of an assignment
    # expression must be a simple name like "a", and expressions are right-associative.
    # (In other words, "a = b = c" is parsed as "a = (b = c)").
    class AssignParselet
      include InfixParselet

      getter mPrecedence = Precedence::ASSIGNMENT

      def parse(parser : Parser, left : Expression, token : Token) : Expression
        right = parser.parseExpression(Precedence::ASSIGNMENT - 1)

        if !(left.is_a?(NameExpression))
          raise ParseException.new("The left-hand side of an assignment must be a name.")
        end

        name = left.mName

        return AssignExpression.new(name, right)
      end
    end
end

