defmodule Pong.Physics do
  alias Pong.Ball
  alias Pong.Score

  def update(%{ball: ball} = game) do
    ball = Ball.move(ball)

    game = resolve_collisions(%{game | ball: ball})
    increment_score game
  end

  defp increment_score(%{arena: arena, ball: ball, scores: scores} = game) do
    cond do
      ball_crossed_left_goalline?(game) ->
        scores = Score.increment_right(scores)
        ball = Ball.update_position(ball, arena.center)
        %{game | ball: ball, scores: scores}
      ball_crossed_right_goalline?(game) ->
        scores = Score.increment_left(scores)
        %{game | ball: ball, scores: scores}
      true ->
        game
    end
  end

  defp ball_crossed_left_goalline?(%{arena: arena, ball: ball} = _game) do
    ball.position.x <= arena.left_goalline
  end

  defp ball_crossed_right_goalline?(%{arena: arena, ball: ball} = _game) do
    ball.position.x >= arena.right_goalline
  end

  defp resolve_collisions(game) do
    cond do
      collision_with_top_wall?(game) ->
        game = rebound_ball_off_top_wall(game)
        resolve_collisions game
      collison_with_bottom_wall?(game) ->
        game = rebound_ball_off_bottom_wall(game)
        resolve_collisions game
      collision_with_left_paddle?(game) ->
        game = rebound_ball_off_left_paddle(game)
        resolve_collisions game
      collision_with_right_paddle?(game) ->
        game = rebound_ball_off_right_paddle(game)
        resolve_collisions game
      true ->
        game
    end
  end

  defp collision_with_left_paddle?(game) do
    ball_reached_left_goalline?(game) and
      ball_is_aligned_with_left_paddle?(game)
  end

  defp ball_reached_left_goalline?(%{arena: arena, ball: ball} = _game) do
    ball.position.x <= arena.left_goalline
  end

  defp ball_is_aligned_with_left_paddle?(%{ball: ball, paddles: paddles} = _game) do
    paddles.y_left <= ball.position.y and
      ball.position.y <= paddles.y_left + paddles.paddle_length
  end

  defp collision_with_right_paddle?(game) do
    ball_reached_right_goalline?(game) and
      ball_is_aligned_with_right_paddle?(game)
  end

  defp ball_reached_right_goalline?(%{arena: arena, ball: ball} = _game) do
    ball.position.x >= arena.right_goalline
  end

  defp ball_is_aligned_with_right_paddle?(%{ball: ball, paddles: paddles} = _game) do
    paddles.y_right <= ball.position.y and
      ball.position.y <= paddles.y_right + paddles.paddle_length
  end

  defp collision_with_top_wall?(%{arena: arena, ball: ball} = _game) do
    ball.position.y >= arena.top_wall
  end

  defp collison_with_bottom_wall?(%{arena: arena, ball: ball} = _game) do
    ball.position.y <= arena.bottom_wall
  end

  defp rebound_ball_off_top_wall(%{arena: arena, ball: ball} = game) do
    new_position = %{y: arena.top_wall - 1}
    ball = Ball.update_position(ball, new_position)
    ball = Ball.inverse_y_direction(ball)
    %{game | ball: ball}
  end

  defp rebound_ball_off_bottom_wall(%{arena: arena, ball: ball} = game) do
    new_position = %{y: arena.bottom_wall + 1}
    ball = Ball.update_position(ball, new_position)
    ball = Ball.inverse_y_direction(ball)
    %{game | ball: ball}
  end

  defp rebound_ball_off_left_paddle(%{arena: arena, ball: ball} = game) do
    new_position = %{x: arena.left_goalline + 1}
    ball = Ball.update_position(ball, new_position)
    ball = Ball.inverse_x_direction(ball)
    %{game | ball: ball}
  end

  defp rebound_ball_off_right_paddle(%{arena: arena, ball: ball} = game) do
    new_position = %{x: arena.right_goalline - 1}
    ball = Ball.update_position(ball, new_position)
    ball = Ball.inverse_x_direction(ball)
    %{game | ball: ball}
  end
end
