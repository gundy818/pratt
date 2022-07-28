
require "./spec_helper"

describe Pratt::Lexer do
  it "initialises" do
    Pratt::Lexer.new("")
  end

  eof = Pratt::Token.new(Pratt::TokenType::Type::EOF, "")

  describe "#next" do
    it "handles empty string" do
      lexer = Pratt::Lexer.new("")
      token = lexer.next()
      token.should eq(eof)
    end

    describe "call" do
      it "parses empty call" do
        lexer = Pratt::Lexer.new("a()")
        expected = [
          Pratt::Token.new(Pratt::TokenType::Type::NAME, "a"),
          Pratt::Token.new(Pratt::TokenType::Type::LEFT_PAREN, "("),
          Pratt::Token.new(Pratt::TokenType::Type::RIGHT_PAREN, ")"),
        ]

        expected.each do |token|
          lexer.next.should eq(token)
        end
        lexer.next.should eq(eof)
      end

      it "parses empty call" do
        lexer = Pratt::Lexer.new("a(x, yy, zzz)")
        expected = [
          Pratt::Token.new(Pratt::TokenType::Type::NAME, "a"),
          Pratt::Token.new(Pratt::TokenType::Type::LEFT_PAREN, "("),
          Pratt::Token.new(Pratt::TokenType::Type::NAME, "x"),
          Pratt::Token.new(Pratt::TokenType::Type::COMMA, ","),
          Pratt::Token.new(Pratt::TokenType::Type::NAME, "yy"),
          Pratt::Token.new(Pratt::TokenType::Type::COMMA, ","),
          Pratt::Token.new(Pratt::TokenType::Type::NAME, "zzz"),
          Pratt::Token.new(Pratt::TokenType::Type::RIGHT_PAREN, ")")
        ]
        expected.each do |token|
          lexer.next.should eq(token)
        end
        lexer.next.should eq(eof)
      end
    end
  end

  describe "#next" do
    lexer = Pratt::Lexer.new("")
    token = lexer.next()
    token.should eq(Pratt::Token.new(Pratt::TokenType::Type::EOF, ""))
  end
end

