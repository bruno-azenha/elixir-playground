defmodule Debugland.Processes.ForkBomb do
  alias Debugland.Processes.ForkBomb

  @doc """
  The classic
  """
  def run() do
    Process.sleep(10000)
    Task.start(fn -> ForkBomb.run() end)
    Task.start(fn -> ForkBomb.run() end)
  end
end
