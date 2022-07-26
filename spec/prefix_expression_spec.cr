require "./spec_helper"

describe Pratt::PrefixExpression do
  it "prints" do
    ae = Pratt::PrefixExpression.new(Pratt::TokenType::Type::BANG,
                                     Pratt::NameExpression.new("aname"))
    ae.print.should eq("(!aname)")
  end
end

