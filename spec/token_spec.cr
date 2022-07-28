
require "./spec_helper"

describe Pratt::Token do
  token = Pratt::Token.new(Pratt::TokenType::Type::COMMA, ",")

  token.m_type.should eq(Pratt::TokenType::Type::COMMA)
  token.m_text.should eq(",")
end

