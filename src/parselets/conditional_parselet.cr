
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

    getter m_precedence = Precedence::CONDITIONAL

    def parse(parser : Parser, left : Expression, token : Token) : Expression
      then_arm = parser.parse_expression()
      parser.consume(TokenType::Type::COLON)
      else_arm = parser.parse_expression(Precedence::CONDITIONAL - 1)

      return ConditionalExpression.new(left, then_arm, else_arm)
    end
  end
end

