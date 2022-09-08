defmodule VolcampTest do
  use ExUnit.Case
  doctest Volcamp

  test "greets the world" do
    assert Volcamp.hello() == :world
  end
end
