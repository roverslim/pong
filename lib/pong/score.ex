defmodule Pong.Score do
  def increment_left(%{left: left} = scores) do
    %{scores | left: left + 1}
  end

  def increment_right(%{right: right} = scores) do
    %{scores | right: right + 1}
  end
end
