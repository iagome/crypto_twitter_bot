defmodule CryptoTwitterBot.MixProject do
  use Mix.Project

  def project do
    [
      app: :crypto_twitter_bot,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:httpoison, "~> 1.8"},
      {:extwitter, "~> 0.12"},
      {:oauther, "~> 1.1"}
    ]
  end
end
