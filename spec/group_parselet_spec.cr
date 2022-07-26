require "./spec_helper"

describe Pratt::GroupParselet do
  it "parses" do
    lexer = Pratt::Lexer.new("zzz)")
    parser = Pratt::Parser.new(lexer)
    parser.register(Pratt::TokenType::Type::NAME,
                    Pratt::NameParselet.new)
    parselet = Pratt::GroupParselet.new
    result = parselet.parse(
      parser,
      Pratt::Token.new(Pratt::TokenType::Type::LEFT_PAREN, "("))

    # not quiet sure why this returns 'zzz', not '(zzz)'
    result.print.should eq("zzz")
  end
end

