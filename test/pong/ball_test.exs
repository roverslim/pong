defmodule Pong.BallTest do
  use ExUnit.Case, async: true
  alias Pong.Ball
  import Pong.TestHelper

  test "#move returns a ball position translated by the direction vector (x, y)" do
    ball = new_ball(%{direction: %{y: 1}})
    expected_ball = new_ball(%{
      position: %{x: 201, y: 151},
      direction: ball.direction,
    })
    assert expected_ball == Ball.move(ball)
  end

  test "#move returns a ball position translated by the direction vector (x, -y)" do
    ball = new_ball(%{direction: %{y: -1}})
    expected_ball = new_ball(%{
      position: %{x: 201, y: 149},
      direction: ball.direction,
    })
    assert expected_ball == Ball.move(ball)
  end

  test "#move returns a ball position translated by the direction vector (-x, -y)" do
    ball = new_ball(%{direction: %{x: -1, y: -1}})
    expected_ball = new_ball(%{
      position: %{x: 199, y: 149},
      direction: ball.direction,
    })
    assert expected_ball == Ball.move(ball)
  end

  test "#move returns a ball position translated by the direction vector (-x, y)" do
    ball = new_ball(%{direction: %{x: -1, y: 1}})
    expected_ball = new_ball(%{
      position: %{x: 199, y: 151},
      direction: ball.direction,
    })
    assert expected_ball == Ball.move(ball)
  end

  test "#update_position returns a ball with the indicated position" do
    ball = new_ball(%{})
    expected_ball = new_ball(%{position: %{x: 250, y: 300}})
    assert expected_ball == Ball.update_position(ball, %{x: 250, y: 300})
  end

  test "#inverse_x_direction returns a ball with the x-component of the direction inverted" do
    ball = new_ball(%{direction: %{x: 3}})
    expected_ball = new_ball(%{direction: %{x: -3}})
    assert expected_ball == Ball.inverse_x_direction(ball)
  end

  test "#inverse_y_direction returns a ball with the y-component of the direction inverted" do
    ball = new_ball(%{direction: %{y: 3}})
    expected_ball = new_ball(%{direction: %{y: -3}})
    assert expected_ball == Ball.inverse_y_direction(ball)
  end
end
