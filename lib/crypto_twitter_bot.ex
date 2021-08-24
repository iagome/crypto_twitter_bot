defmodule CryptoTwitterBot do
  @moduledoc """
  Documentation for `CryptoTwitterBot`.
  """

  alias CryptoTwitterBot.CryptoFetch

  @tweet_intro "Current prices for $AXS, $ETH and $SLP are:\n"

  @doc """
  Starts the bot.
  Fetches for crypto prices:
    If the return is ok, tweets the prices, else shows error and doesn't tweet.
  """
  def start do
    case CryptoFetch.crypto_info do
      {:ok, crypto} ->
        IO.puts("-----> Caught all prices, building tweet!")

        "#{@tweet_intro}#{axs_prices(crypto)}#{eth_prices(crypto)}#{slp_prices(crypto)}"
        |> ExTwitter.update()

        IO.puts("-----> Tweet successfully posted!")
      {:error, reason} ->
        IO.puts(reason)
    end
  end

  defp axs_prices(crypto), do: "$AXS: 🇺🇸 -> #{crypto.usd.axs} // 🇧🇷 -> #{crypto.brl.axs}\n"

  defp eth_prices(crypto), do: "$ETH: 🇺🇸 -> #{crypto.usd.eth} // 🇧🇷 -> #{crypto.brl.eth}\n"

  defp slp_prices(crypto), do: "$SLP: 🇺🇸 -> #{crypto.usd.slp} // 🇧🇷 -> #{crypto.brl.slp}"
end
