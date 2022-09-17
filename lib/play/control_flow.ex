defmodule ControlFlow do
  def __using__(_opts) do
    require ControlFlow
  end

  defmacro bind_name(string) do
    quote do
      var!(name) = unquote(string)
    end
  end

  defmacro unless(expression, do: block) do
    quote do
      if !unquote(expression), do: unquote(block)
    end
  end

  defmacro definfo do
    IO.puts "In macro's context (#{__MODULE__})."

    quote do
      IO.puts "In caller's context (#{__MODULE__})."

      def friendly_info do
        IO.puts """
        My name is #{__MODULE__}
        """
      end
    end
  end
end
