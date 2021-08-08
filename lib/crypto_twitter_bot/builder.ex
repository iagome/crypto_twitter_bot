defmodule CryptoTwitterBot.Builder do
  @moduledoc """
  Public documentation for `Builder`.
  """

  @doc """
  Builds the crypto prices map
  """
  @spec build_prices(map, String.t()) :: map
  def build_prices(data, currency) do
    %{
      axs: get_price(data, "AXS", currency),
      eth: get_price(data, "ETH", currency),
      slp: get_price(data, "SLP", currency)
    }
  end

  @doc """
  Builds the response for BRL and USD crypto prices
  """
  @spec build_response(map, map) :: map
  def build_response(crypto_brl, crypto_usd) do
    %{
      brl: crypto_brl,
      usd: crypto_usd
    }
  end

  defp get_price(data, coin, currency) do
    data[coin]["quote"][currency]["price"]
    |> round_price(coin)
    |> format_to_currency(coin, currency)
  end

  defp round_price(price, _coin = "SLP"), do: Float.round(price, 5)
  defp round_price(price, _coin), do: Float.round(price, 2)

  defp format_to_currency(price, coin, _currency = "BRL") do
    case coin do
      "SLP" ->
        Number.Currency.number_to_currency(price, unit: "R$", separator: ",", delimiter: ".", precision: 5)
      _ ->
        Number.Currency.number_to_currency(price, unit: "R$", separator: ",", delimiter: ".")
    end
  end

  defp format_to_currency(price, coin, _currency = "USD") do
    case coin do
      "SLP" ->
        Number.Currency.number_to_currency(price, unit: "$", separator: ".", delimiter: ",", precision: 5)
      _ ->
        Number.Currency.number_to_currency(price, unit: "$", separator: ".", delimiter: ",")
    end
  end
end
