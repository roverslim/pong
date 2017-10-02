defmodule Pong.Renderer do
  def render_game(_linear_interpolator) do
    IO.inspect "rendering..."
    :timer.sleep 5
  end
end
