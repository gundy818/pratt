require "./spec_helper"

describe Pratt::AssignParselet do
  it "parses" do
    lexer = Pratt::Lexer.new("zzz")
    parser = Pratt::Parser.new(lexer)
    parser.register(Pratt::TokenType::Type::NAME,
                    Pratt::NameParselet.new)
    parselet = Pratt::AssignParselet.new
    result = parselet.parse(
      parser,
      Pratt::NameExpression.new("aname"),
      Pratt::Token.new(Pratt::TokenType::Type::ASSIGN, "="))

    result.print.should eq("(aname = zzz)")
  end
end

