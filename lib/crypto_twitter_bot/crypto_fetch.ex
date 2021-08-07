defmodule CryptoTwitterBot.CryptoFetch do
  @moduledoc """
  Public documentation for `CryptoFetch`.
  """

  @base_url "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest"
  @api_key System.get_env("COIN_MARKET_API_KEY")
  @headers [
    "X-CMC_PRO_API_KEY": @api_key,
    "Accept": "application/json"
  ]
  @params [params: [symbol: "ETH,SLP,AXS"]]

  @doc """
  Fetches latest info on AXS, ETH and SLP coins
  """
  @spec crypto_info :: {:ok, map()} | {:error, String}
  def crypto_info do
    case HTTPoison.get(@base_url, @headers, @params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, %{"data" => data}} = Jason.decode(body)
        {:ok, build_response(data)}
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:error, "Not found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp build_response(data) do
    %{
      axs: get_price(data, "AXS"),
      eth: get_price(data, "ETH"),
      slp: get_price(data, "SLP")
    }
  end

  defp get_price(data, coin) do
    data[coin]["quote"]["USD"]["price"]
    |> round_price(coin)
  end

  defp round_price(price, _coin = "SLP"), do: Float.round(price, 5)
  defp round_price(price, _coin), do: Float.round(price, 2)
end
