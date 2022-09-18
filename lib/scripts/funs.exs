repeat = fn times, args, fun ->
  Enum.each(1..times, fn index ->
    case args do
      args when is_list(args) -> apply(fun, args)
      args when is_function(args) -> apply(fun, apply(args, [index]))
    end
  end)
end

repeat.(3, fn num -> [num] end, fn val -> IO.puts(val) end)

defmodule Foo do
  def(greet, do: (
    IO.puts("one")
    IO.puts("two")
  ))
end

Foo.greet()
