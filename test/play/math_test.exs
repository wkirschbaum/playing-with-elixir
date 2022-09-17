defmodule Play.MathTest do
  use ExUnit.Case

  alias Play.Math

  describe "factorial" do
    @tag timeout: :timer.minutes(5)
    test "large number" do
      assert Math.factorial(20) == Math.factorial_v2(20)
      IO.inspect("Answer matches with #{Math.factorial(20)}")

      Benchee.run(%{
        "v1 1k" => fn -> Math.factorial(1_000) end,
        "v2 1k" => fn -> Math.factorial_v2(1_000) end,
        "v3 1k" => fn -> Math.fact(1_000) end
      })

      Benchee.run(%{
        "v1 one" => fn -> Math.factorial(1) end,
        "v2 one" => fn -> Math.factorial_v2(1) end,
        "v3 one" => fn -> Math.fact(1) end
      })

      # Benchee.run(%{
      #   "v1 100k" => fn -> Math.factorial(100_000) end,
      #   "v2 100k" => fn -> Math.factorial_v2(100_000) end
      # })
    end
  end

  describe "fib" do
    @tag timeout: :timer.minutes(5)
    test "large number" do
      Benchee.run(%{
        "v1" => fn input -> Math.fib_v1(input) end,
        "v3" => fn input -> Math.fib_v3(input) end
                  },
        inputs: %{"small" => 1, "medium" => 1_000, "large" => 100_000},
        after_each: fn _input -> Memoize.invalidate(Play.Math, :fib_v1) end
      )

    end
  end
end
