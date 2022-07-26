require "./spec_helper"

describe Pratt::NameExpression do
  it "prints" do
    ae = Pratt::NameExpression.new("aname")
    ae.print.should eq("aname")
  end
end

