require "./spec_helper"

describe Pratt::NameParselet do
  it "parses" do
    lexer = Pratt::Lexer.new("")
    parser = Pratt::Parser.new(lexer)
    parser.register(Pratt::TokenType::Type::NAME,
                    Pratt::NameParselet.new)
    parselet = Pratt::NameParselet.new
    result = parselet.parse(
      parser,
      Pratt::Token.new(Pratt::TokenType::Type::NAME, "aaa"))

    result.print.should eq("aaa")
  end
end

