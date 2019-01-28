defmodule Debugland.Processes.RunForever do
  @doc """
  Run forever :)
  """
  def run() do
    sum_to_x(-1)
  end

  def sum_to_x(x), do: do_sum_to_x(x, 0)

  def do_sum_to_x(0, acc), do: acc

  # initial function call
  def do_sum_to_x(x, acc) do
    do_sum_to_x(x - 1, acc + x)
  end
end
