
require "./expression"


module Pratt

  # A simple variable name expression like "abc".
  class NameExpression
    include Expression

    getter m_name : String

    def initialize(@m_name)
    end

    def print() : String
      return @m_name
    end
  end
end

