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
    @mRead = [] of Token

    # List of registered prefix parselets
    @mPrefixParselets = {} of TokenType::Type => PrefixParselet

    # List of registered infix parselets
    @mInfixParselets = {} of TokenType::Type => InfixParselet

    # this provides the stream of tokens to parse. It is implemented by the lexer
    @mTokens : Iterator(Token)

    def initialize(@mTokens)
    end

    def register(token : TokenType::Type, parselet : PrefixParselet)
      @mPrefixParselets[token] = parselet
    end

    def register(token : TokenType::Type, parselet : InfixParselet)
      @mInfixParselets[token] = parselet
    end

    def parseExpression(precedence : Precedence) : Expression
      # grab the first token
      token = consume()

      begin
        prefix : PrefixParselet = @mPrefixParselets[token.mType]
      rescue KeyError
        raise ParseException.new("No prefix parser registered for type #{token.mType}")
      end
      left : Expression = prefix.parse(self, token)

      while precedence < getPrecedence()
        token = consume()
        begin
          infix : InfixParselet = @mInfixParselets[token.mType]
        rescue KeyError
          raise ParseException.new("No infix parser registered for type #{token.mType}")
        end
        left = infix.parse(self, left, token)
      end

      return left
    end

    def parseExpression() : Expression
      # ths was originally this:
      # return parseExpression(0)
      # crystal and java both assign '0' as the value of the first enum element. So the
      # zero here seems to refer to the lowest (first) value. I defined a precedence
      # DEFAULT which is the first available value.
      return parseExpression(Precedence::DEFAULT)
    end

    def match(expected : TokenType::Type) : Bool
      token = lookAhead(0)

      return false unless token.mType == expected

      consume()
      return true
    end

    def consume(expected : TokenType::Type) : Token
      token = lookAhead(0)
      if token.mType != expected
        raise ParseException.new("Expected token #{expected} and found #{token.mType} ('#{token.mText}')")
      end

      return consume()
    end

    def consume() : Token
      # Make sure we've read the token.
      result = lookAhead(0)
      @mRead.shift

      return result
    end

    def lookAhead(distance) : Token
      # Read in as many as needed.
      # This depends on the input providing an endless stream of EOFs, which it doesnt
      # currently
      while (distance >= @mRead.size())
        @mRead << @mTokens.next()
      end

      # Get the queued token.
      return @mRead[distance]
    end

    def getPrecedence()
      parser : InfixParselet? = @mInfixParselets[lookAhead(0).mType]?
      return Precedence::DEFAULT if parser.nil?

      return parser.as(InfixParselet).mPrecedence
    end
  end
end

