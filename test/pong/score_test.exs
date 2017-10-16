defmodule Pong.ScoreTest do
  use ExUnit.Case, async: true
  alias Pong.Score

  test "#increment_left bumps the left score by 1" do
    scores = %{left: 0}
    assert %{left: 1} == Score.increment_left(scores)
  end

  test "#increment_right bumps the left score by 1" do
    scores = %{right: 0}
    assert %{right: 1} == Score.increment_right(scores)
  end
end
