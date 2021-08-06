defmodule CryptoTwitterBot do
  @moduledoc """
  Documentation for `CryptoTwitterBot`.
  """

  alias CryptoTwitterBot.CryptoFetch

  @doc """
  TODO
  """
  def start do
    # roda a cada X minutos (preciso pesquisar como fazer isso)
    with {:ok, slp} <- CryptoFetch.slp_info,
         {:ok, axs} <- CryptoFetch.axs_info,
         {:ok, eth} <- CryptoFetch.eth_info do
      IO.puts("-----> Caught all prices, building tweet!")
    else
      _ -> {:error, "Can't fetch prices"}
    end


  end
end
