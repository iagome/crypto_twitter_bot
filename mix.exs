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
      extra_applications: [:logger, :jason]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:extwitter, "~> 0.12"},
      {:oauther, git: "https://github.com/tobstarr/oauther.git", branch: "master", override: true},
      {:jason, "~> 1.2"},
      {:number, "~> 1.0.1"}
    ]
  end
end
