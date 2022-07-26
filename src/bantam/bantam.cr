
require "./bantam_parser"


module Bantam

  class Main
    property sPassed = 0
    property sFailed = 0

    def main()
      # Function call.
      test("a()", "a()");
      test("a(b)", "a(b)");
      test("a(b, c)", "a(b, c)");
      test("a(b)(c)", "a(b)(c)");
      test("a(b) + c(d)", "(a(b) + c(d))");
      test("a(b ? c : d, e + f)", "a((b ? c : d), (e + f))");

      # Unary precedence.
      test("~!-+a", "(~(!(-(+a))))");
      test("a!!!", "(((a!)!)!)");

      # Unary and binary predecence.
      test("-a * b", "((-a) * b)");
      test("!a + b", "((!a) + b)");
      test("~a ^ b", "((~a) ^ b)");
      test("-a!",    "(-(a!))");
      test("!a!",    "(!(a!))");

      # Binary precedence.
      test("a = b + c * d ^ e - f / g", "(a = ((b + (c * (d ^ e))) - (f / g)))");

      # Binary associativity.
      test("a = b = c", "(a = (b = c))");
      test("a + b - c", "((a + b) - c)");
      test("a * b / c", "((a * b) / c)");
      test("a ^ b ^ c", "(a ^ (b ^ c))");
    
      # Conditional operator.
      test("a ? b : c ? d : e", "(a ? b : (c ? d : e))");
      test("a ? b ? c : d : e", "(a ? (b ? c : d) : e)");
      test("a + b ? c * d : e / f", "((a + b) ? (c * d) : (e / f))");
    
      # Grouping.
      test("a + (b + c) + d", "((a + (b + c)) + d)");
      test("a ^ (b + c)", "(a ^ (b + c))");
      test("(!a)!",    "((!a)!)");
    
      # Show the results.
      if @sFailed == 0
        puts("Passed all #{@sPassed} tests.")
      else
        puts("----")
        puts("Failed #{@sFailed} out of #{@sFailed + @sPassed} tests.")
      end
    end

    # Parses the given chunk of code and verifies that it matches the expected
    # pretty-printed result.
    def test(source : String, expected : String)
      lexer = Pratt::Lexer.new(source)
      parser = BantamParser.new(lexer)

      begin
        result = parser.parseExpression()
        actual = result.print()

        if expected == actual
          @sPassed += 1
        else
          @sFailed += 1
          puts("[FAIL] Expected: #{expected}")
          puts("         Actual: #{actual}")
        end
      rescue ex : Pratt::ParseException
        @sFailed += 1
        puts("[FAIL] Expected: #{expected}")
        puts("          Error: #{ex}")
      end
    end
  end
end

main = Bantam::Main.new()
main.main()

