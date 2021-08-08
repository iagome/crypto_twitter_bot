defmodule CryptoTwitterBot.CryptoFetch do
  @moduledoc """
  Public documentation for `CryptoFetch`.
  """

  alias CryptoTwitterBot.Builder

  @base_url "https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest"
  @headers [
    "X-CMC_PRO_API_KEY": System.get_env("COIN_MARKET_API_KEY"),
    "Accept": "application/json"
  ]
  @params [params: [symbol: "ETH,SLP,AXS"]]
  @params_brl [params: [symbol: "ETH,SLP,AXS", convert: "BRL"]]

  @doc """
  Fetches latest info on AXS, ETH and SLP coins
  """
  @spec crypto_info :: {:ok, map} | {:error, String.t()}
  def crypto_info do
    with {:ok, crypto_usd} <- get_usd_prices(),
         {:ok, crypto_brl} <- get_brl_prices() do
      {:ok, Builder.build_response(crypto_brl, crypto_usd)}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp get_usd_prices do
    case HTTPoison.get(@base_url, @headers, @params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, %{"data" => data}} = Jason.decode(body)
        {:ok, Builder.build_prices(data, "USD")}
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:error, "Not found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp get_brl_prices do
    case HTTPoison.get(@base_url, @headers, @params_brl) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, %{"data" => data}} = Jason.decode(body)
        {:ok, Builder.build_prices(data, "BRL")}
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:error, "Not found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
