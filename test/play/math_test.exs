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
    end
  end

  describe "fib" do
    @tag timeout: :timer.minutes(5)
    test "all" do
      assert Math.fib_v1(20) == Math.fib_v2(20)
      assert Math.fib_v2(20) == Math.fib_v3(20)
      assert Math.fib_v3(20) == Math.fib_v4(20)
      assert Math.fib_v4(20) == Math.fib_v5(20)

      Benchee.run(
        %{
          "v1" => fn input -> Math.fib_v1(input) end,
          "v2" => fn input -> Math.fib_v2(input) end,
          "v3" => fn input -> Math.fib_v3(input) end,
          "v4" => fn input -> Math.fib_v4(input) end,
          "v5" => fn input -> Math.fib_v5(input) end,
          "v6" => fn input -> Math.fib_v6(input) end,
          "v7" => fn input -> Math.fib_v7(input) end
        },
        inputs: %{"small" => 1, "medium" => 1_000, "large" => 100_000, "xlarge" => 200_000},
        after_each: fn _input -> Memoize.invalidate(Play.Math, :fib_v1) end
      )
    end

    @tag timeout: :timer.minutes(5)
    test "nx" do
      assert Math.fib_v5(20) == Math.fib_v6(20)
      assert Math.fib_v6(20) == Math.fib_v7(20)

      Benchee.run(
        %{
          "v5" => fn input -> Math.fib_v5(input) end,
          "v6" => fn input -> Math.fib_v6(input) end,
          "v7" => fn input -> Math.fib_v7(input) end
        },
        inputs: %{"large" => 1_000_000}
      )
    end
  end
end
