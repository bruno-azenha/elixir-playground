defmodule Debugland.MixProject do
  use Mix.Project

  def project do
    [
      app: :debugland,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Debugland.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:distillery, "~> 2.0"},
      {:recon, "~> 2.3"},
      {:observer_cli, "~> 1.4"}
    ]
  end
end
