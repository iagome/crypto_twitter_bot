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
    with {:ok, crypto} <- CryptoFetch.crypto_info do
      IO.puts("-----> Caught all prices, building tweet!")

    else
      {:error, reason} -> IO.puts(reason)
    end
  end
end
