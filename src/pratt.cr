# This module provides a Pratt parser, as described at
# https://journal.stuffwithstuff.com/2011/03/19/pratt-parsers-expression-parsing-made-easy/.
#
# To use the module:
#
# ```
# require "pratt"
# ```
#
# This gioves you access to the parser components. You then need to initialise the
# parser to describe the language that you're parsing. See src/bantam for an example, or
# read the above web page.
#


require "./exceptions"
require "./lexer"
require "./parselets/*"
require "./parser"
require "./precedence"
require "./tokentype"

module Pratt
  VERSION = "0.1.0"

end

