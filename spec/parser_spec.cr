
require "./spec_helper"

describe Pratt::Parser do
  it "initialises" do
    lexer = Pratt::Lexer.new("abc")
    Pratt::Parser.new(lexer)
  end

  describe "#register PrefixParselet" do
    lexer = Pratt::Lexer.new("abc+-z")
    parser = Pratt::Parser.new(lexer)

    parser.register(Pratt::TokenType::Type::NAME, Pratt::NameParselet.new)
    result = parser.parse_expression()
    result.print.should eq("abc")
  end

  describe "#register InfixParselet" do
    lexer = Pratt::Lexer.new("abc=xyz")
    parser = Pratt::Parser.new(lexer)

    parser.register(Pratt::TokenType::Type::NAME, Pratt::NameParselet.new)
    parser.register(Pratt::TokenType::Type::ASSIGN, Pratt::AssignParselet.new)
    result = parser.parse_expression()
    result.print.should eq("(abc = xyz)")
  end

  pending "#parse_expression(precedence)" do
  end

  pending "#parse_expression()" do
  end

  describe "#match" do
    lexer = Pratt::Lexer.new("a+-z")
    parser = Pratt::Parser.new(lexer)

    it "ignores mismatch" do
      # should be false
      parser.match(Pratt::TokenType::Type::PLUS).should eq(false)
      # and the next token is the 'a'
      parser.look_ahead(0).m_text.should eq("a")
      parser.look_ahead(1).m_text.should eq("+")
    end

    it "matches lookahead" do
      parser.match(Pratt::TokenType::Type::NAME).should eq(true)
    end

    it "consumes match" do
      parser.look_ahead(0).m_text.should eq("+")
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

  describe "#look_ahead" do
    lexer = Pratt::Lexer.new("a+-z")
    parser = Pratt::Parser.new(lexer)

    it "doesnt consume tokens" do
      # should be false
      parser.look_ahead(0).m_text.should eq("a")
      parser.look_ahead(1).m_text.should eq("+")
      parser.look_ahead(2).m_text.should eq("-")
      parser.look_ahead(3).m_text.should eq("z")
      parser.consume.m_text.should eq("a")
    end
  end

  describe "#get_precedence" do
    lexer = Pratt::Lexer.new("+-z")
    parser = Pratt::Parser.new(lexer)

    it "returns default if unknown" do
      token = parser.look_ahead(0)
      token.m_type = Pratt::TokenType::Type.new(99)
      parser.get_precedence.should eq(Pratt::Precedence::DEFAULT)
    end
  end
end

