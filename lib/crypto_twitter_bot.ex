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

  defp axs_prices(crypto) do
    "$AXS: 🇺🇸 -> #{crypto.axs.usd} // 🇧🇷 -> #{crypto.axs.brl} 📈 #{crypto.axs.percentage}\n"
  end

  defp eth_prices(crypto) do
    "$ETH: 🇺🇸 -> #{crypto.eth.usd} // 🇧🇷 -> #{crypto.eth.brl} 📈 #{crypto.eth.percentage}\n"
  end

  defp slp_prices(crypto) do
    "$SLP: 🇺🇸 -> #{crypto.slp.usd} // 🇧🇷 -> #{crypto.slp.brl} 📈 #{crypto.slp.percentage}"
  end
end
