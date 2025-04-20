defmodule PastorTest do
  use ExUnit.Case
  doctest Pastor

  test "greets the world" do
    assert Pastor.hello() == :world
  end
end
