
require "../parser"
require "../token"
require "../expressions/expression"
require "../expressions/name_expression"


module Pratt

  # Simple parselet for a named variable like "abc".
  class NameParselet
    include PrefixParselet

    def parse(parser : Parser, token : Token) : Expression
      return NameExpression.new(token.mText)
    end
  end
end

