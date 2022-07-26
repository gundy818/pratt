
require "./spec_helper"

describe Pratt::Parser do
  it "initialises" do
    lexer = Pratt::Lexer.new("abc")
    parser = Pratt::Parser.new(lexer)
  end

  describe "#register PrefixParselet" do
    lexer = Pratt::Lexer.new("abc+-z")
    parser = Pratt::Parser.new(lexer)

    parser.register(Pratt::TokenType::Type::NAME, Pratt::NameParselet.new)
    result = parser.parseExpression()
    result.print.should eq("abc")
  end

  describe "#register InfixParselet" do
    lexer = Pratt::Lexer.new("abc=xyz")
    parser = Pratt::Parser.new(lexer)

    parser.register(Pratt::TokenType::Type::NAME, Pratt::NameParselet.new)
    parser.register(Pratt::TokenType::Type::ASSIGN, Pratt::AssignParselet.new)
    result = parser.parseExpression()
    result.print.should eq("(abc = xyz)")
  end

  pending "#parseExpression(precedence)" do
  end

  pending "#parseExpression()" do
  end

  describe "#match" do
    lexer = Pratt::Lexer.new("a+-z")
    parser = Pratt::Parser.new(lexer)

    expected = [
      Pratt::Token.new(Pratt::TokenType::Type::NAME, "a"),
      Pratt::Token.new(Pratt::TokenType::Type::RIGHT_PAREN, ")"),
      Pratt::Token.new(Pratt::TokenType::Type::NAME, "bc"),
      Pratt::Token.new(Pratt::TokenType::Type::LEFT_PAREN, "("),
      Pratt::Token.new(Pratt::TokenType::Type::RIGHT_PAREN, ")"),
      Pratt::Token.new(Pratt::TokenType::Type::NAME, "a"),
      Pratt::Token.new(Pratt::TokenType::Type::NAME, "b"),
      Pratt::Token.new(Pratt::TokenType::Type::PLUS, "+"),
      Pratt::Token.new(Pratt::TokenType::Type::MINUS, "-"),
      Pratt::Token.new(Pratt::TokenType::Type::EOF, "")
    ]

    it "ignores mismatch" do
      # should be false
      parser.match(Pratt::TokenType::Type::PLUS).should eq(false)
      # and the next token is the 'a'
      parser.lookAhead(0).mText.should eq("a")
      parser.lookAhead(1).mText.should eq("+")
    end

    it "matches lookahead" do
      parser.match(Pratt::TokenType::Type::NAME).should eq(true)
    end

    it "consumes match" do
      parser.lookAhead(0).mText.should eq("+")
    end
  end

  describe "#consume" do
    # this doesn't check every posibility, but just to be sure it's separating tokens
    lexer = Pratt::Lexer.new("a)bc() a b +-")
    parser = Pratt::Parser.new(lexer)

    expected = [
      Pratt::Token.new(Pratt::TokenType::Type::NAME, "a"),
      Pratt::Token.new(Pratt::TokenType::Type::RIGHT_PAREN, ")"),
      Pratt::Token.new(Pratt::TokenType::Type::NAME, "bc"),
      Pratt::Token.new(Pratt::TokenType::Type::LEFT_PAREN, "("),
      Pratt::Token.new(Pratt::TokenType::Type::RIGHT_PAREN, ")"),
      Pratt::Token.new(Pratt::TokenType::Type::NAME, "a"),
      Pratt::Token.new(Pratt::TokenType::Type::NAME, "b"),
      Pratt::Token.new(Pratt::TokenType::Type::PLUS, "+"),
      Pratt::Token.new(Pratt::TokenType::Type::MINUS, "-"),
      Pratt::Token.new(Pratt::TokenType::Type::EOF, "")
    ]

    it "tokenises stream" do
      expected.each do |token|
        parser.consume.should eq(token)
      end
    end
  end

  describe "#consume(expected)" do
    # this doesn't check every posibility, but just to be sure it's separating tokens
    lexer = Pratt::Lexer.new("a)bc() a b +-")
    parser = Pratt::Parser.new(lexer)

    expected = Pratt::Token.new(Pratt::TokenType::Type::NAME, "a")

    it "matches expected" do
      parser.consume(Pratt::TokenType::Type::NAME).should eq(expected)
    end

    it "rejects the unexpected" do
      # now positioned at the RIGHT_PAREN
      expect_raises(Pratt::ParseException, "Expected token NAME and found RIGHT_PAREN") do
        parser.consume(Pratt::TokenType::Type::NAME).should eq(expected)
      end
    end
  end

  describe "#lookAhead" do
    lexer = Pratt::Lexer.new("a+-z")
    parser = Pratt::Parser.new(lexer)

    it "doesnt consume tokens" do
      # should be false
      parser.lookAhead(0).mText.should eq("a")
      parser.lookAhead(1).mText.should eq("+")
      parser.lookAhead(2).mText.should eq("-")
      parser.lookAhead(3).mText.should eq("z")
      parser.consume.mText.should eq("a")
    end
  end

  describe "#getPrecedence" do
    lexer = Pratt::Lexer.new("+-z")
    parser = Pratt::Parser.new(lexer)

    it "returns default if unknown" do
      token = parser.lookAhead(0)
      token.mType = Pratt::TokenType::Type.new(99)
      parser.getPrecedence.should eq(Pratt::Precedence::DEFAULT)
    end
  end
end

