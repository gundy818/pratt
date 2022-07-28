
require "../parser"
require "../precedence"
require "../token"
require "../expressions/expression"
require "../expressions/postfix_expression"


module Pratt

  # Generic infix parselet for an unary arithmetic operator. Parses postfix unary "?"
  # expressions.
  class PostfixOperatorParselet
    include InfixParselet

    getter m_precedence : Precedence

    def initialize(@m_precedence)
    end

    def parse(parser : Parser, left : Expression, token : Token) : Expression
      return PostfixExpression.new(left, token.m_type)
    end
  end
end

