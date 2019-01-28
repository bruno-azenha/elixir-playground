defmodule Debugland.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      {Task.Supervisor, strategy: :one_for_one, name: Debugland.TaskSupervisor},
      Debugland.ProcessSpawner
    ]

    opts = [strategy: :one_for_one, name: Debugland.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
