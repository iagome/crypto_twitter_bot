defmodule CryptoTwitterBot.CryptoFetch do
  @moduledoc """
  Public documentation for `CryptoFetch`.
  """

  alias CryptoTwitterBot.Builder

  @base_url "https://api.coingecko.com/api/v3/coins/"
  @headers ["Accept": "application/json"]

  @doc """
  Fetches latest info on AXS, ETH and SLP coins
  """
  @spec crypto_info :: {:ok, map} | {:error, String.t()}
  def crypto_info do
    with {:ok, slp_prices} <- get_slp(),
         {:ok, eth_prices} <- get_eth(),
         {:ok, axs_prices} <- get_axs() do
      {:ok, Builder.build_response(slp_prices, eth_prices, axs_prices)}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  defp get_slp do
    case HTTPoison.get(@base_url <> "smooth-love-potion", @headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, data} = Jason.decode(body)
        {:ok, Builder.get_price(data, "SLP")}
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:error, "Not found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp get_eth do
    case HTTPoison.get(@base_url <> "ethereum", @headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, data} = Jason.decode(body)
        {:ok, Builder.get_price(data, "ETH")}
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:error, "Not found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp get_axs do
    case HTTPoison.get(@base_url <> "axie-infinity", @headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, data} = Jason.decode(body)
        {:ok, Builder.get_price(data, "AXS")}
      {:ok, %HTTPoison.Response{status_code: 400}} ->
        {:error, "Not found"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
