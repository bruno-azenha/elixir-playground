defmodule Debugland.Processes.WorkAndWait do
  @doc """
  Do some work, wait and do some more work after a while
  """
  def run() do
    loop()
  end

  def loop() do
    Process.send_after(self(), :wait, 5000)

    receive do
      :wait -> Task.start(fn -> spawn_cpu_bound_processes(10000) end)
    end

    loop()
  end

  defp spawn_cpu_bound_processes(0), do: :ok

  defp spawn_cpu_bound_processes(n) do
    Task.start(fn -> spawn_cpu_bound_processes(n - 1) end)
    expensive_computing()
  end

  defp expensive_computing() do
    Enum.reduce(1..9_999, 0, fn x, acc -> x + acc end)
  end
end
