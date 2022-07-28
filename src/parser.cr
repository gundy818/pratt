# The actual parser module. It doesn't know about any language until you define one
# using the register functions.
#

require "./expressions/expression"
require "./parselets/infix_parselet"
require "./parselets/prefix_parselet"
require "./parser"

module Pratt
  class Parser
    # Tokens that have been read from the lexer, available for lookahead
    @m_read = [] of Token

    # List of registered prefix parselets
    @m_prefix_parselets = {} of TokenType::Type => PrefixParselet

    # List of registered infix parselets
    @m_infix_parselets = {} of TokenType::Type => InfixParselet

    # this provides the stream of tokens to parse. It is implemented by the lexer
    @m_tokens : Iterator(Token)

    def initialize(@m_tokens)
    end

    def register(token : TokenType::Type, parselet : PrefixParselet)
      @m_prefix_parselets[token] = parselet
    end

    def register(token : TokenType::Type, parselet : InfixParselet)
      @m_infix_parselets[token] = parselet
    end

    def parse_expression(precedence : Precedence) : Expression
      # grab the first token
      token = consume()

      begin
        prefix : PrefixParselet = @m_prefix_parselets[token.m_type]
      rescue KeyError
        raise ParseException.new("No prefix parser registered for type #{token.m_type}")
      end
      left : Expression = prefix.parse(self, token)

      while precedence < get_precedence()
        token = consume()
        begin
          infix : InfixParselet = @m_infix_parselets[token.m_type]
        rescue KeyError
          raise ParseException.new("No infix parser registered for type #{token.m_type}")
        end
        left = infix.parse(self, left, token)
      end

      return left
    end

    def parse_expression() : Expression
      # ths was originally this:
      # return parse_expression(0)
      # crystal and java both assign '0' as the value of the first enum element. So the
      # zero here seems to refer to the lowest (first) value. I defined a precedence
      # DEFAULT which is the first available value.
      return parse_expression(Precedence::DEFAULT)
    end

    def match(expected : TokenType::Type) : Bool
      token = look_ahead(0)

      return false unless token.m_type == expected

      consume()
      return true
    end

    def consume(expected : TokenType::Type) : Token
      token = look_ahead(0)
      if token.m_type != expected
        raise ParseException.new("Expected token #{expected} and found #{token.m_type} ('#{token.m_text}')")
      end

      return consume()
    end

    def consume() : Token
      # Make sure we've read the token.
      result = look_ahead(0)
      @m_read.shift

      return result
    end

    def look_ahead(distance) : Token
      # Read in as many as needed.
      # This depends on the input providing an endless stream of EOFs, which it doesnt
      # currently
      while (distance >= @m_read.size())
        @m_read << @m_tokens.next()
      end

      # Get the queued token.
      return @m_read[distance]
    end

    def get_precedence()
      parser : InfixParselet? = @m_infix_parselets[look_ahead(0).m_type]?
      return Precedence::DEFAULT if parser.nil?

      return parser.as(InfixParselet).m_precedence
    end
  end
end

