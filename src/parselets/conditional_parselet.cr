
require "../parser"
require "../precedence"
require "../token"
require "../tokentype"
require "../expressions/conditional_expression"
require "../expressions/expression"


module Pratt
  # Parselet for the condition or "ternary" operator, like "a ? b : c".
  class ConditionalParselet
    include InfixParselet

    getter mPrecedence = Precedence::CONDITIONAL

    def parse(parser : Parser, left : Expression, token : Token) : Expression
      thenArm = parser.parseExpression()
      parser.consume(TokenType::Type::COLON)
      elseArm = parser.parseExpression(Precedence::CONDITIONAL - 1)

      return ConditionalExpression.new(left, thenArm, elseArm)
    end
  end
end

