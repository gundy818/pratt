
module Pratt

  # Defines the different precedence levels used by the infix parsers. These determine
  # how a series of infix expressions will be grouped. For example, "a + b * c - d" will
  # be parsed as "(a + (b * c)) - d" because "*" has higher precedence than "+" and "-".
  # Here, bigger numbers mean higher precedence.

  enum Precedence
    # Ordered in increasing precedence.
    # the thing should end when precedence is zero, which corresponds to the end
    DEFAULT = 0
    ASSIGNMENT
    CONDITIONAL
    SUM
    PRODUCT
    EXPONENT
    PREFIX
    POSTFIX
    CALL
  end
end

