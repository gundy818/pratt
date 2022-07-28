
module Pratt
  module TokenType
    enum Type
      LEFT_PAREN
      RIGHT_PAREN
      COMMA
      ASSIGN
      PLUS
      MINUS
      ASTERISK
      SLASH
      CARET
      TILDE
      BANG
      QUESTION
      COLON
      NAME
      EOF
    end

    # If the TokenType represents a punctuator (i.e. a token that can split an identifier
    # like '+', this will get its text.
    def punctuator(token : Type) : Char?
      chars = {
        Type::LEFT_PAREN => '(',
        Type::RIGHT_PAREN => ')',
        Type::COMMA => ',',
        Type::ASSIGN => '=',
        Type::PLUS => '+',
        Type::MINUS => '-',
        Type::ASTERISK => '*',
        Type::SLASH => '/',
        Type::CARET => '^',
        Type::TILDE => '~',
        Type::BANG => '!',
        Type::QUESTION => '?',
        Type::COLON => ':'
      }

      return chars.fetch(token, nil)
    end
  end
end

