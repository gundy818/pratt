require "./spec_helper"

describe Pratt::PostfixExpression do
  it "prints" do
    ae = Pratt::PostfixExpression.new(Pratt::NameExpression.new("aname"),
                                      Pratt::TokenType::Type::BANG)
    ae.print.should eq("(aname!)")
  end
end

