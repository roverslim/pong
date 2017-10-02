defmodule Pong.Timestep do
  @fps 100
  @dt 1 / @fps
  @clamp 0.2

  def start do
    run time_now(), 0
  end

  defp run(frame_start, accumulator) do
    current_time = time_now()
    new_accumulator = accumulator + current_time - frame_start

    update current_time, new_accumulator
  end

  defp time_now do
    DateTime.to_unix DateTime.utc_now
  end

  defp update(frame_start, accumulator) when accumulator > @clamp do
    update frame_start, @clamp
  end

  defp update(frame_start, accumulator) when accumulator > @dt do
    Pong.Physics.update
    update frame_start, accumulator - @dt
  end

  defp update(frame_start, accumulator) do
    linear_interpolator = accumulator / @dt
    Pong.Renderer.render_game(linear_interpolator)
    run frame_start, accumulator
  end
end
