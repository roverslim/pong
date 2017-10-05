defmodule Pong.Timestep do
  alias Pong.Physics
  alias Pong.Renderer

  @fps 100
  @dt 1 / @fps
  @clamp 0.2

  def start(game) do
    run game, time_now(), 0
  end

  defp run(game, frame_start, accumulator) do
    current_time = time_now()
    new_accumulator = accumulator + current_time - frame_start

    update game, current_time, new_accumulator
  end

  defp time_now do
    DateTime.to_unix DateTime.utc_now
  end

  defp update(game, frame_start, accumulator) when accumulator > @clamp do
    update game, frame_start, @clamp
  end

  defp update(game, frame_start, accumulator) when accumulator > @dt do
    updated_game = Physics.update(game)
    update updated_game, frame_start, accumulator - @dt
  end

  defp update(game, frame_start, accumulator) do
    linear_interpolator = accumulator / @dt
    Renderer.render_game game, linear_interpolator
    run game, frame_start, accumulator
  end
end
