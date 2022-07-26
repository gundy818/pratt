
require "./spec_helper"

describe Pratt::Token do
  token = Pratt::Token.new(Pratt::TokenType::Type::COMMA, ",")

  token.mType.should eq(Pratt::TokenType::Type::COMMA)
  token.mText.should eq(",")
end

