require "./spec_helper"

describe Pratt::AssignExpression do
  it "prints" do
    ae = Pratt::AssignExpression.new("aname", Pratt::NameExpression.new("abc"))
    ae.print.should eq("(aname = abc)")
  end
end

