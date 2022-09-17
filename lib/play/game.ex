defmodule Play.Game do
  use GenServer

  require Logger

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts)
  end

  @impl true
  def init(_opts) do
    Logger.debug("Starting game")

    {:ok, nil}
  end

  @impl true
  def handle_info({sender, :ping}, state) do
    send(sender, {self(), :pong})

    {:noreply, state}
  end
end
