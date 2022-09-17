defmodule Play.Math do
  use Memoize

  defmacro say({:+, _, [lhs, rhs]}) do
    quote do
      lhs = unquote(lhs)
      rhs = unquote(rhs)
      result = lhs + rhs
      IO.puts("#{lhs} plus #{rhs} is #{result}")

      result
    end
  end

  defmacro say({:*, _, [lhs, rhs]}) do
    quote do
      lhs = unquote(lhs)
      rhs = unquote(rhs)
      result = lhs * rhs
      IO.puts("#{lhs} times #{rhs} is #{result}")

      result
    end
  end

  defmemo(fact(1), do: 1)
  defmemo fact(num) when num > 0 do
    num * fact(num - 1)
  end

  defmemo fib_v1(num) when num > 1 do
    fib_v1(num - 1) + fib_v1(num - 2)
  end


  def factorial(1), do: 1

  def factorial(num) when num > 0 do
    num * factorial(num - 1)
  end

  def factorial_v2(num) when num > 0 do
    {:ok, pid} = Agent.start(fn -> %{} end)
    result = do_factorial(num, pid)
    Agent.stop(pid)
    result
  end

  defp do_factorial(1, _pid), do: 1

  defp do_factorial(num, pid) do
    case Agent.get(pid, fn state -> Map.get(state, num, nil) end) do
      nil ->
        val = num * do_factorial(num - 1, pid)
        Agent.update(pid, fn state -> Map.put(state, num, val) end)
        val

      val ->
        val
    end
  end

  defmemo(fib_v1(0), do: 0)
  defmemo(fib_v1(1), do: 1)

  defmemo fib_v1(num) when num > 1 do
    fib_v1(num - 1) + fib_v1(num - 2)
  end

  def fib_v3(num) when num > 0 do
    :ets.new(:cache, [:public, :set, :named_table, {:read_concurrency, true}])
    result = do_fib_v3(num)
    :ets.delete(:cache)
    result
  end

  defp do_fib_v3(0), do: 0
  defp do_fib_v3(1), do: 1

  defp do_fib_v3(num) when num > 0 do
    case :ets.lookup(:cache, num) do
      [] ->
        val = do_fib_v3(num - 2) + do_fib_v3(num - 1)
        :ets.insert_new(:cache, {num, val})
        val

      [{_, val}] ->
        val
    end
  end
end
