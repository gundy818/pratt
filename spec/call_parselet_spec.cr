require "./spec_helper"

describe Pratt::CallParselet do
  it "initialises" do
    p = Pratt::CallParselet.new
  end

  it "parses abc()" do
    lexer = Pratt::Lexer.new(")")
    parser = Pratt::Parser.new(lexer)
    parser.register(Pratt::TokenType::Type::NAME, Pratt::NameParselet.new)
    parselet = Pratt::CallParselet.new
    result = parselet.parse(parser,
                            Pratt::NameExpression.new("aname"),
                            Pratt::Token.new(Pratt::TokenType::Type::LEFT_PAREN, "("))
    result.print.should eq("aname()")
  end

  it "parses abc(x, yy, zzz)" do
    lexer = Pratt::Lexer.new("x, yy, zzz)")
    parser = Pratt::Parser.new(lexer)
    parser.register(Pratt::TokenType::Type::NAME, Pratt::NameParselet.new)
    parselet = Pratt::CallParselet.new
    result = parselet.parse(parser,
                          Pratt::NameExpression.new("aname"),
                          Pratt::Token.new(Pratt::TokenType::Type::LEFT_PAREN, "("))
    result.print.should eq("aname(x, yy, zzz)")
  end
end

