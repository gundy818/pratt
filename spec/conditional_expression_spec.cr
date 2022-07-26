require "./spec_helper"

describe Pratt::ConditionalExpression do
  it "prints" do
    ae = Pratt::ConditionalExpression.new(Pratt::NameExpression.new("result"),
                                          Pratt::NameExpression.new("then"),
                                          Pratt::NameExpression.new("else"))
    ae.print.should eq("(result ? then : else)")
  end
end

