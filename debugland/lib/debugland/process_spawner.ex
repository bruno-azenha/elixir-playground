defmodule Debugland.ProcessSpawner do
  alias Debugland.Processes.{RunForever, WorkAndWait, ForkBomb}

  def fork_bomb() do
    spawn_process(&ForkBomb.run/0)
  end

  def work_and_wait() do
    spawn_process(&WorkAndWait.run/0)
  end

  def run_forever() do
    spawn_process(&RunForever.run/0)
  end

  defp spawn_process(function) do
    Task.start(fn -> function.() end)
  end
end
