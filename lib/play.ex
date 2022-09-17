defmodule Play do
  @moduledoc """
  Documentation for `Play`.
  """

  require Logger

  def start do
    case Play.Game.start_link() do
      {:ok, pid} -> ping(pid)
    end
  end

  defp ping(pid) do
    send(pid, {self(), :ping})

    receive do
      {^pid, :pong} ->
        IO.puts("Got pong")
        ping(pid)
    after
      2000 ->
        Logger.warning("Timed out")
    end
  end
end
