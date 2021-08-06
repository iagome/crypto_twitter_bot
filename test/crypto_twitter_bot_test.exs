defmodule CryptoTwitterBotTest do
  use ExUnit.Case
  doctest CryptoTwitterBot

  test "greets the world" do
    assert CryptoTwitterBot.hello() == :world
  end
end
