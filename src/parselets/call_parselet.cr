
require "../parser"
require "../precedence"
require "../token"
require "../tokentype"
require "../expressions/call_expression"
require "../expressions/expression"


module Pratt

  # Parselet to parse a function call like "a(b, c, d)".
  class CallParselet
    include InfixParselet

    getter m_precedence = Precedence::CALL

    def parse(parser : Parser, left : Expression, token : Token) : Expression
      # Parse the comma-separated arguments until we hit, ")".
      args = Array(Expression).new

      if !parser.match(TokenType::Type::RIGHT_PAREN)
        # there are arguments, so get the first one,
        args << parser.parse_expression()

        # then get the remaining
        # match discards the comma, so the parseexpression is on the next argument
        while (parser.match(TokenType::Type::COMMA))
          args << parser.parse_expression()
        end
        parser.consume(TokenType::Type::RIGHT_PAREN)
      end
      return CallExpression.new(left, args)
    end
  end
end

