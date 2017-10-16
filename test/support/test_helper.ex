defmodule Pong.TestHelper do
  defmacro setup_ball_position(game, new_position) do
    quote bind_quoted: [game: game, new_position: new_position] do
      %{ball: ball} = game
      new_ball = %{ball | position: Map.merge(ball.position, new_position)}
      %{game | ball: new_ball}
    end
  end

  defmacro setup_ball_direction(game, new_direction) do
    quote bind_quoted: [game: game, new_direction: new_direction] do
      %{ball: ball} = game
      new_ball = %{ball | direction: Map.merge(ball.direction, new_direction)}
      %{game | ball: new_ball}
    end
  end

  defmacro setup_paddles(game, new_paddles) do
    quote bind_quoted: [game: game, new_paddles: new_paddles] do
      %{game | paddles: Map.merge(game.paddles, new_paddles)}
    end
  end

  defmacro new_game do
    quote do
      %{
        arena: %{
          bottom_wall: 0,
          center: %{x: 200, y: 150},
          top_wall: 300,
          left_goalline: 0,
          right_goalline: 400,
        },
        ball: %{
          position: %{x: 200, y: 150},
          direction: %{x: 1, y: 0},
        },
        paddles: %{paddle_length: 10, y_left: 145, y_right: 145},
        scores: %{left: 0, right: 0},
      }
    end
  end

  defmacro new_ball(configuration) do
    quote bind_quoted: [configuration: configuration] do
      position = configuration[:position]
      direction = configuration[:direction]

      position = if position, do: position, else: %{}
      direction = if direction, do: direction, else: %{}

      ball = new_game().ball
      new_position = Map.merge(ball.position, position)
      new_direction = Map.merge(ball.direction, direction)

      Map.merge ball, %{position: new_position, direction: new_direction}
    end
  end
end
