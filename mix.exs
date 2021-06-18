defmodule WiseHomex.MixProject do
  use Mix.Project

  def project do
    [
      app: :wise_homex,
      version: "0.6.122",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      elixirc_paths: elixirc_paths(Mix.env()),
      dialyzer: dialyzer()
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
      {:quantity, "~> 0.6"},

      # JSON parsing
      {:jason, "~> 1.1"},

      # HTTP Client
      {:httpoison, "~> 1.0"},

      # Static code analysis
      {:credo, "~> 1.0", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0.0", only: [:dev, :test], runtime: false},

      # Documentation
      {:ex_doc, "~> 0.21", only: [:dev]}
    ]
  end

  defp aliases do
    [
      compile: ["compile --warnings-as-errors"]
    ]
  end

  defp elixirc_paths(:test), do: ~w[lib test/support]
  defp elixirc_paths(_), do: ~w[lib]

  defp dialyzer do
    [
      plt_add_apps: [:ex_unit]
    ]
  end
end
