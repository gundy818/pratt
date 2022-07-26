
require "../parser"
require "../token"
require "../tokentype"
require "../expressions/expression"


module Pratt
  # Parses parentheses used to group an expression, like "a * (b + c)".
  class GroupParselet
    include PrefixParselet

    def parse(parser : Parser, token : Token) : Expression
      expression = parser.parseExpression()
      parser.consume(TokenType::Type::RIGHT_PAREN)

      return expression
    end
  end
end

