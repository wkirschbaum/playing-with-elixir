defmodule ControlFlowTest do
  use ExUnit.Case

  require ControlFlow

  describe "unless" do
    test "returns not" do
      ControlFlow.unless false do
        IO.inspect("yes")
      end
    end
  end
end
