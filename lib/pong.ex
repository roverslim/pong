defmodule Pong do
  alias Pong.Timestep

  @paddle_length 10

  def start(
    x_start \\ 200,
    y_start \\ 200,
    x_direction \\ 1,
    y_direction \\ 0,
    height \\ 300,
    width \\ 400
  ) do
    paddle_start_y = height / 2 - @paddle_length / 2

    game = %{
      arena: %{
        bottom_wall: 0,
        center: %{x: x_start, y: y_start},
        top_wall: height,
        left_goalline: 0,
        right_goalline: width,
      },
      ball: %{
        position: %{x: x_start, y: y_start},
        direction: %{x: x_direction, y: y_direction},
      },
      paddles: %{
        paddle_length: @paddle_length,
        y_left: paddle_start_y,
        y_right: paddle_start_y,
      },
      scores: %{
        left: 0,
        right: 0,
      },
    }

    Timestep.start(game)
  end
end
