require "./spec_helper"

describe Pratt::CallExpression do
  it "prints" do
    ae = Pratt::CallExpression.new(Pratt::NameExpression.new("abc"), [] of Pratt::Expression)
    ae.print.should eq("abc()")
  end
end

