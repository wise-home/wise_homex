defmodule WiseHomex.MixProject do
  use Mix.Project

  def project do
    [
      app: :wise_homex,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto, "~> 3.0"},

      # JSON parsing
      {:jason, "~> 1.1"},

      # HTTP Client
      {:httpoison, "~> 1.0"},

      # Static code analysis
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 0.4", only: [:dev, :test], runtime: false},

      # Documentation
      {:ex_doc, "~> 0.19.3"}
    ]
  end

  defp aliases do
    [
      compile: ["compile --warnings-as-errors"]
    ]
  end
end
