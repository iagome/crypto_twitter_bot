defmodule CryptoTwitterBot do
  @moduledoc """
  Documentation for `CryptoTwitterBot`.
  """

  alias CryptoTwitterBot.CryptoFetch

  @doc """
  Starts the bot.
  Fetches for crypto prices:
    If the return is ok, tweets the prices, else shows error and doesn't tweet.
  """
  def start do
    # roda a cada X minutos (preciso pesquisar como fazer isso)
    case CryptoFetch.crypto_info do
      {:ok, crypto} ->
        IO.puts("-----> Caught all prices, building tweet!")

        "Current prices for $AXS, $ETH and $SLP are:\n$AXS: 🇺🇸 -> #{crypto.usd.axs} // 🇧🇷 -> #{crypto.brl.axs}\n$ETH: 🇺🇸 -> #{crypto.usd.eth} // 🇧🇷 -> #{crypto.brl.eth}\n$SLP: 🇺🇸 -> #{crypto.usd.slp} // 🇧🇷 -> #{crypto.brl.slp}"
        |> ExTwitter.update()

        IO.puts("-----> Tweet successfully posted!")
      {:error, reason} -> IO.puts(reason)
    end
  end
end
