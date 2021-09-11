defmodule BuilderTest do
  use ExUnit.Case

  alias CryptoTwitterBot.Builder

  describe "get_price/2" do
    setup do
      slp = %{
        "market_data" => %{
          "current_price" => %{
            "brl" => 0.469194,
            "usd" => 0.089438
          },
          "price_change_percentage_24h" => -1.5633
        }
      }
      eth = %{
        "market_data" => %{
          "current_price" => %{
            "brl" => 17424.21,
            "usd" => 3321.43
          },
          "price_change_percentage_24h" => -0.60772
        }
      }
      axs = %{
        "market_data" => %{
          "current_price" => %{
            "brl" => 367.28,
            "usd" => 70.01
          },
          "price_change_percentage_24h" => 4.71656
        }
      }

      %{slp: slp, eth: eth, axs: axs}
    end

    test "successfully builds SLP prices", %{slp: data} do
      assert %{brl: brl, usd: usd, percentage: percentage} = Builder.get_price(data, "SLP")
      assert brl == "R$0,46919"
      assert usd == "$0.08944"
      assert percentage == "-1.56%"
    end

    test "successfully builds ETH prices", %{eth: data} do
      assert %{brl: brl, usd: usd, percentage: percentage} = Builder.get_price(data, "ETH")
      assert brl == "R$17.424,21"
      assert usd == "$3,321.43"
      assert percentage == "-0.61%"
    end

    test "successfully builds AXS prices", %{axs: data} do
      assert %{brl: brl, usd: usd, percentage: percentage} = Builder.get_price(data, "AXS")
      assert brl == "R$367,28"
      assert usd == "$70.01"
      assert percentage == "4.72%"
    end
  end

  describe "build_response/2" do
    setup do
      slp = %{brl: "R$0,46919", usd: "$0.08944", percentage: "-1.56%"}
      eth = %{brl: "R$17.424,21", usd: "$3,321.43", percentage: "-0.61%"}
      axs = %{brl: "R$367,28", usd: "$70.01", percentage: "4.72%"}

      %{slp: slp, eth: eth, axs: axs}
    end

    test "successfully builds response", %{slp: slp_price, eth: eth_price, axs: axs_price} do
      assert %{slp: slp, eth: eth, axs: axs} = Builder.build_response(slp_price, eth_price, axs_price)
      assert slp == slp_price
      assert eth == eth_price
      assert axs == axs_price
    end
  end
end
