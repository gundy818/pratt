
require "./bantam_parser"


module Bantam

  class Main
    property s_passed = 0
    property s_failed = 0

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
      if @s_failed == 0
        puts("Passed all #{@s_passed} tests.")
      else
        puts("----")
        puts("Failed #{@s_failed} out of #{@s_failed + @s_passed} tests.")
      end
    end

    # Parses the given chunk of code and verifies that it matches the expected
    # pretty-printed result.
    def test(source : String, expected : String)
      lexer = Pratt::Lexer.new(source)
      parser = BantamParser.new(lexer)

      begin
        result = parser.parse_expression()
        actual = result.print()

        if expected == actual
          @s_passed += 1
        else
          @s_failed += 1
          puts("[FAIL] Expected: #{expected}")
          puts("         Actual: #{actual}")
        end
      rescue ex : Pratt::ParseException
        @s_failed += 1
        puts("[FAIL] Expected: #{expected}")
        puts("          Error: #{ex}")
      end
    end
  end
end

main = Bantam::Main.new()
main.main()

