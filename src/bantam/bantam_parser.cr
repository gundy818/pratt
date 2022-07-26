
require "../pratt"


module Bantam
  # Extends the generic Parser class with support for parsing the actual Bantam grammar.
  class BantamParser < Pratt::Parser
    include Pratt::TokenType
  
    def initialize(lexer : Iterator(Pratt::Token))
      super
  
      # Register all of the parselets for the grammar.
  
      # Register the ones that need special parselets.
      register(Type::NAME,       Pratt::NameParselet.new())
      register(Type::ASSIGN,     Pratt::AssignParselet.new())
      register(Type::QUESTION,   Pratt::ConditionalParselet.new())
      register(Type::LEFT_PAREN, Pratt::GroupParselet.new())
      register(Type::LEFT_PAREN, Pratt::CallParselet.new())
  
      # Register the simple operator parselets.
      prefix(Type::PLUS,      Pratt::Precedence::PREFIX)
      prefix(Type::MINUS,     Pratt::Precedence::PREFIX)
      prefix(Type::TILDE,     Pratt::Precedence::PREFIX)
      prefix(Type::BANG,      Pratt::Precedence::PREFIX)
      
      # For kicks, we'll make "!" both prefix and postfix, kind of like ++.
      postfix(Type::BANG,     Pratt::Precedence::POSTFIX)
  
      infixLeft(Type::PLUS,     Pratt::Precedence::SUM)
      infixLeft(Type::MINUS,    Pratt::Precedence::SUM)
      infixLeft(Type::ASTERISK, Pratt::Precedence::PRODUCT)
      infixLeft(Type::SLASH,    Pratt::Precedence::PRODUCT)
      infixRight(Type::CARET,   Pratt::Precedence::EXPONENT)
    end
  
    # Registers a postfix unary operator parselet for the given token and
    # precedence.
    def postfix(token : Type, precedence : Pratt::Precedence)
      register(token, Pratt::PostfixOperatorParselet.new(precedence))
    end
  
    # Registers a prefix unary operator parselet for the given token and precedence.
    def prefix(token : Type, precedence : Pratt::Precedence)
      register(token, Pratt::PrefixOperatorParselet.new(precedence))
    end
  
    # Registers a left-associative binary operator parselet for the given token
    # and precedence.
    def infixLeft(token : Type, precedence : Pratt::Precedence)
      register(token, Pratt::BinaryOperatorParselet.new(precedence, false))
    end
  
    # Registers a right-associative binary operator parselet for the given token
    # and precedence.
    def infixRight(token : Type, precedence : Pratt::Precedence)
      register(token, Pratt::BinaryOperatorParselet.new(precedence, true))
    end
  end
end

