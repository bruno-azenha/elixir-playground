defmodule Debugland.ProcessSpawner do
  use GenServer

  alias Debugland.Processes.RunForever

  @impl true
  def init(_state) do
    {:ok, nil, {:continue, :init}}
  end

  @impl true
  def handle_continue(:init, state) do
    send(self(), :spawn_process)
    {:noreply, state}
  end

  @impl true
  def handle_info(:spawn_process, state) do
    spawn_process()
    Process.send_after(self(), :spawn_process, 10000)
    {:noreply, state}
  end

  def handle_info(msg, state) do
    IO.puts("Handle handle info: #{inspect(msg)}")
    {:noreply, state}
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  defp spawn_process() do
    Task.Supervisor.start_child(Debugland.TaskSupervisor, fn -> RunForever.run() end)
  end
end
