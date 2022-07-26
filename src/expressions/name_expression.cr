
require "./expression"


module Pratt

  # A simple variable name expression like "abc".
  class NameExpression
    include Expression

    getter mName : String

    def initialize(@mName)
    end

    def print() : String
      return @mName
    end
  end
end

