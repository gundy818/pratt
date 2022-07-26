require "./spec_helper"

describe Pratt::BinaryOperatorParselet do
  it "parses" do
    lexer = Pratt::Lexer.new("zzz")
    parser = Pratt::Parser.new(lexer)
    parser.register(Pratt::TokenType::Type::NAME,
                    Pratt::NameParselet.new)
    parselet = Pratt::BinaryOperatorParselet.new(Pratt::Precedence.new(0), false)
    result = parselet.parse(
      parser,
      Pratt::NameExpression.new("aname"),
      Pratt::Token.new(Pratt::TokenType::Type::PLUS, "+"))

    result.print.should eq("(aname + zzz)")
  end
end

