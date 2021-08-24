defmodule BuilderTest do
  use ExUnit.Case

  alias CryptoTwitterBot.Builder

  describe "build_prices/2" do
    setup do
      usd_data = %{
        "AXS" => %{"quote" => %{"USD" => %{"price" => 70.78849291856461}}},
        "ETH" => %{"quote" => %{"USD" => %{"price" => 3201.8732407862444}}},
        "SLP" => %{"quote" => %{"USD" => %{"price" => 0.14095104215845}}}
      }
      brl_data = %{
        "AXS" => %{"quote" => %{"BRL" => %{"price" => 431.78849291856461}}},
        "ETH" => %{"quote" => %{"BRL" => %{"price" => 16997.8732407862444}}},
        "SLP" => %{"quote" => %{"BRL" => %{"price" => 0.74095104215845}}}
      }

      %{usd_data: usd_data, brl_data: brl_data}
    end

    test "successfully builds USD prices", %{usd_data: data} do
      assert %{axs: axs, eth: eth, slp: slp} = Builder.build_prices(data, "USD")
      assert axs == "$70.79"
      assert eth == "$3,201.87"
      assert slp == "$0.14095"
    end

    test "successfully builds brl prices", %{brl_data: data} do
      assert %{axs: axs, eth: eth, slp: slp} = Builder.build_prices(data, "BRL")
      assert axs == "R$431,79"
      assert eth == "R$16.997,87"
      assert slp == "R$0,74095"
    end
  end

  describe "build_response/2" do
    setup do
      crypto_brl = %{axs: "R$371,42", eth: "R$16.799,75", slp: "R$0,73955"}
      crypto_usd = %{axs: "$70.79", eth: "$3,201.87", slp: "$0.14095"}

      %{crypto_brl: crypto_brl, crypto_usd: crypto_usd}
    end

    test "successfully builds response", %{crypto_brl: crypto_brl, crypto_usd: crypto_usd} do
      assert %{brl: brl, usd: usd} = Builder.build_response(crypto_brl, crypto_usd)
      assert brl == crypto_brl
      assert usd == crypto_usd
    end
  end
end
