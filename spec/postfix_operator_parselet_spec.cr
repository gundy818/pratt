require "./spec_helper"

describe Pratt::PostfixOperatorParselet do
  it "parses" do
    lexer = Pratt::Lexer.new("")
    parser = Pratt::Parser.new(lexer)
    parser.register(Pratt::TokenType::Type::NAME,
                    Pratt::NameParselet.new)
    parselet = Pratt::PostfixOperatorParselet.new(Pratt::Precedence.new(0))
    result = parselet.parse(
      parser,
      Pratt::NameExpression.new("aname"),
      Pratt::Token.new(Pratt::TokenType::Type::BANG, "!"))

    result.print.should eq("(aname!)")
  end
end

