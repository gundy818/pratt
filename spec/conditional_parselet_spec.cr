require "./spec_helper"

describe Pratt::ConditionalParselet do
  it "parses" do
    lexer = Pratt::Lexer.new("zzz : aaa")
    parser = Pratt::Parser.new(lexer)
    parser.register(Pratt::TokenType::Type::NAME,
                    Pratt::NameParselet.new)
    parselet = Pratt::ConditionalParselet.new
    result = parselet.parse(
      parser,
      Pratt::NameExpression.new("aname"),
      Pratt::Token.new(Pratt::TokenType::Type::QUESTION, "?"))

    result.print.should eq("(aname ? zzz : aaa)")
  end
end

