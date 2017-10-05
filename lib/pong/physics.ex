defmodule Pong.Physics do
  def update(game) do
    game = move_ball(game)
    game = increment_score(game)
    game
  end

  defp increment_score(game) do
    cond do
      ball_crossed_left_goalline?(game) ->
        game = increment_score_right(game)
        reset_ball game
      ball_crossed_right_goalline?(game) ->
        game = increment_score_left(game)
        reset_ball game
      true ->
        game
    end
  end

  defp reset_ball(%{arena: arena, ball: ball} = game) do
    # TODO: randomize direction
    ball = %{ball | position: arena.center}
    %{game | ball: ball}
  end

  defp increment_score_left(%{scores: scores} = game) do
    scores = %{scores | left: scores.left + 1}
    %{game | scores: scores}
  end

  defp increment_score_right(%{scores: scores} = game) do
    scores = %{scores | right: scores.right + 1}
    %{game | scores: scores}
  end

  defp ball_crossed_left_goalline?(%{arena: arena, ball: ball} = _game) do
    %{position: position} = ball
    position.x <= arena.left_goalline
  end

  defp ball_crossed_right_goalline?(%{arena: arena, ball: ball} = _game) do
    %{position: position} = ball
    position.x >= arena.right_goalline
  end

  defp move_ball(%{ball: ball} = game) do
    %{position: position, direction: direction} = ball

    position = %{
      x: position.x + direction.x,
      y: position.y + direction.y,
    }
    ball = %{ball | position: position}
    game = %{game | ball: ball}
    resolve_collisions game
  end

  defp resolve_collisions(game) do
    cond do
      collison_with_wall?(game) ->
        ball = rebound_ball_off_wall(game)
        resolve_collisions %{game | ball: ball}
      collision_with_left_paddle?(game) or collision_with_right_paddle?(game) ->
        ball = rebound_ball_off_paddle(game)
        resolve_collisions %{game | ball: ball}
      true ->
        game
    end
  end

  defp collision_with_left_paddle?(%{arena: arena, ball: ball, paddles: paddles} = _game) do
    %{position: position} = ball

    position.x <= arena.left_goalline and
      paddles.y_left <= position.y and
      position.y <= paddles.y_left + paddles.paddle_length
  end

  defp collision_with_right_paddle?(%{arena: arena, ball: ball, paddles: paddles} = _game) do
    %{position: position} = ball

    position.x >= arena.right_goalline and
      paddles.y_right <= position.y and
      position.y <= paddles.y_right + paddles.paddle_length
  end

  defp collison_with_wall?(%{arena: arena, ball: ball} = _game) do
    %{position: position} = ball

    position.y <= arena.bottom_wall or
      position.y >= arena.top_wall
  end

  defp rebound_ball_off_wall(%{arena: arena, ball: ball} = _game) do
    %{position: position, direction: direction} = ball

    new_y = cond do
      position.y <= arena.bottom_wall ->
        arena.bottom_wall + 1
      position.y >= arena.top_wall ->
        arena.top_wall - 1
    end
    new_position = %{position | y: new_y}

    new_direction = %{direction | y: -direction.y}

    %{ball | position: new_position, direction: new_direction}
  end

  defp rebound_ball_off_paddle(%{arena: arena, ball: ball} = _game) do
    %{position: position, direction: direction} = ball

    new_x = cond do
      position.x <= arena.left_goalline ->
        arena.left_goalline + 1
      position.x >= arena.right_goalline ->
        arena.right_goalline - 1
    end
    new_position = %{position | x: new_x}

    new_direction = %{direction | x: -direction.x}

    %{ball | position: new_position, direction: new_direction}
  end
end
