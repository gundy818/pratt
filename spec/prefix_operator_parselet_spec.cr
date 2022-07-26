
require "./spec_helper"

describe Pratt::PrefixOperatorParselet do
  it "parses" do
    lexer = Pratt::Lexer.new("zzz")
    parser = Pratt::Parser.new(lexer)
    parser.register(Pratt::TokenType::Type::NAME,
                    Pratt::NameParselet.new)
    parselet = Pratt::PrefixOperatorParselet.new(Pratt::Precedence::SUM)
    result = parselet.parse(
      parser,
      Pratt::Token.new(Pratt::TokenType::Type::PLUS, "+"))

    result.print.should eq("(+zzz)")
  end
end

