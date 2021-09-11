defmodule CryptoTwitterBot.Builder do
  @moduledoc """
  Public documentation for `Builder`.
  """

  @doc """
  Builds the crypto price map
  """
  @spec get_price(map, String.t()) :: map
  def get_price(data, coin) do
    %{
      brl: price_by_currency(data, coin, "brl"),
      usd: price_by_currency(data, coin, "usd"),
      percentage: format_percentage(data)
    }
  end

  @doc """
  Builds the response for BRL and USD crypto prices
  """
  @spec build_response(map, map, map) :: map
  def build_response(slp_prices, eth_prices, axs_prices) do
    %{
      slp: slp_prices,
      eth: eth_prices,
      axs: axs_prices
    }
  end

  defp price_by_currency(data, coin, currency) do
    data["market_data"]["current_price"][currency]
    |> format_to_currency(coin, currency)
  end

  defp format_to_currency(price, coin, _currency = "brl") do
    case coin do
      "SLP" ->
        Number.Currency.number_to_currency(price, unit: "R$", separator: ",", delimiter: ".", precision: 5)
      _ ->
        Number.Currency.number_to_currency(price, unit: "R$", separator: ",", delimiter: ".")
    end
  end

  defp format_to_currency(price, coin, _currency = "usd") do
    case coin do
      "SLP" ->
        Number.Currency.number_to_currency(price, unit: "$", separator: ".", delimiter: ",", precision: 5)
      _ ->
        Number.Currency.number_to_currency(price, unit: "$", separator: ".", delimiter: ",")
    end
  end

  defp format_percentage(data) do
    data["market_data"]["price_change_percentage_24h"]
    |> Number.Percentage.number_to_percentage(precision: 2)
  end
end
