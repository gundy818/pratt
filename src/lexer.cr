# A very primitive lexer. Takes a string and splits it into a series of Tokens.
# Operators and punctuation are mapped to unique keywords. Names, which can be any
# series of letters, are turned into NAME tokens. All other characters are ignored
# (except to separate names). Numbers and strings are * not supported. This is really
# just the bare minimum to give the parser * something to work with.


require "./token"
require "./tokentype"


module Pratt

  class Lexer
    include Pratt::TokenType
    include Iterator(Token)

    # Creates a new Lexer to tokenize the given string.
    # @param text String to tokenize.

    # the maximum number of eofs to hand out. This is to avoid the infinite case of
    # x = Array.new(lexer)
    # and is a departure from the original Java version.
    @eof_triggered : Int32 = 10

    def initialize(@m_text : String)
      @m_index = 0
      @m_punctuators = Hash(Char, Type).new

      # Register all of the TokenTypes that are explicit punctuators.
      Pratt::TokenType::Type.each do |ttype|
        punctchar = punctuator(ttype)
        @m_punctuators[punctchar] = ttype unless punctchar.nil?
      end
    end

    def next() : Token
      # Return the next token from the text stream.
      #

      while (@m_index < @m_text.size)
        c = @m_text[@m_index]
        @m_index += 1

        if (@m_punctuators.has_key?(c))
          # Handle punctuation.
          return Token.new(@m_punctuators[c], c.to_s)
        elsif c.ascii_letter?
          # Handle names.
          start = @m_index - 1
          while @m_index < @m_text.size
            break unless @m_text[@m_index].ascii_letter?
            @m_index += 1
          end

          # here, m_index points one past the last valid character, so to get the length
          # you need to subtract the start
          name = @m_text[start, @m_index - start]

          return Token.new(Type::NAME, name)
        else
          # Ignore all other characters (whitespace, etc.)
        end
      end

      # Once we've reached the end of the string, just return EOF tokens, up to the
      # limit set in 'eof_triggered'.
      @eof_triggered -= 1
      stop if @eof_triggered < 0

      return Token.new(Type::EOF, "")
    end
  end
end

