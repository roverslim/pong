defmodule Pong.PhysicsTest do
  use ExUnit.Case, async: true
  alias Pong.Physics

  test "#update moves ball to rightwards" do
    game = new_game()

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{x: 201})

    assert expected_game == Physics.update(game)
  end

  test "#update moves ball to leftwards" do
    game = new_game()
    game = setup_ball_direction(game, %{x: -1})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{x: 199})
    expected_game = setup_ball_direction(expected_game, %{x: -1})

    assert expected_game == Physics.update(game)
  end

  test "#update moves ball upwards" do
    game = new_game()
    game = setup_ball_direction(game, %{x: 0, y: 1})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{y: 151})
    expected_game = setup_ball_direction(expected_game, %{x: 0, y: 1})

    assert expected_game == Physics.update(game)
  end

  test "#update moves ball downwards" do
    game = new_game()
    game = setup_ball_direction(game, %{x: 0, y: -1})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{y: 149})
    expected_game = setup_ball_direction(expected_game, %{x: 0, y: -1})

    assert expected_game == Physics.update(game)
  end

  test "#update moves ball diagonally (x, y)" do
    game = new_game()
    game = setup_ball_direction(game, %{y: 1})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{x: 201, y: 151})
    expected_game = setup_ball_direction(expected_game, %{y: 1})

    assert expected_game == Physics.update(game)
  end

  test "#update moves ball diagonally (x, -y)" do
    game = new_game()
    game = setup_ball_direction(game, %{x: 1, y: -1})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{x: 201, y: 149})
    expected_game = setup_ball_direction(expected_game, %{x: 1, y: -1})

    assert expected_game == Physics.update(game)
  end

  test "#update moves ball diagonally (-x, -y)" do
    game = new_game()
    game = setup_ball_direction(game, %{x: -1, y: -1})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{x: 199, y: 149})
    expected_game = setup_ball_direction(expected_game, %{x: -1, y: -1})

    assert expected_game == Physics.update(game)
  end

  test "#update moves ball diagonally (-x, y)" do
    game = new_game()
    game = setup_ball_direction(game, %{x: -1, y: 1})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{x: 199, y: 151})
    expected_game = setup_ball_direction(expected_game, %{x: -1, y: 1})

    assert expected_game == Physics.update(game)
  end

  test "#update rebounds ball off top wall (x, y)" do
    game = new_game()
    game = setup_ball_position(game, %{x: 200, y: 299})
    game = setup_ball_direction(game, %{x: 2, y: 1})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{x: 202, y: 299})
    expected_game = setup_ball_direction(expected_game, %{x: 2, y: -1})

    assert expected_game == Physics.update(game)
  end

  test "#update rebounds ball off top wall (-x, y)" do
    game = new_game()
    game = setup_ball_position(game, %{x: 200, y: 299})
    game = setup_ball_direction(game, %{x: -2, y: 1})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{x: 198, y: 299})
    expected_game = setup_ball_direction(expected_game, %{x: -2, y: -1})

    assert expected_game == Physics.update(game)
  end

  test "#update rebounds ball off bottom wall (x, -y)" do
    game = new_game()
    game = setup_ball_position(game, %{x: 200, y: 1})
    game = setup_ball_direction(game, %{x: 2, y: -1})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{x: 202, y: 1})
    expected_game = setup_ball_direction(expected_game, %{x: 2, y: 1})

    assert expected_game == Physics.update(game)
  end

  test "#update rebounds ball off bottom wall (-x, -y)" do
    game = new_game()
    game = setup_ball_position(game, %{x: 200, y: 1})
    game = setup_ball_direction(game, %{x: -2, y: -1})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{x: 198, y: 1})
    expected_game = setup_ball_direction(expected_game, %{x: -2, y: 1})

    assert expected_game == Physics.update(game)
  end

  test "#update rebounds ball diagonally off bottom wall and left paddle" do
    game = new_game()
    game = setup_ball_position(game, %{x: 1, y: 1})
    game = setup_ball_direction(game, %{x: -1, y: -1})
    game = setup_paddles(game, %{y_left: 0})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{x: 1, y: 1})
    expected_game = setup_ball_direction(expected_game, %{x: 1, y: 1})
    expected_game = setup_paddles(expected_game, %{y_left: 0})

    assert expected_game == Physics.update(game)
  end

  test "#update rebounds ball diagonally off top wall and left paddle" do
    game = new_game()
    game = setup_ball_position(game, %{x: 1, y: 299})
    game = setup_ball_direction(game, %{x: -1, y: 1})
    game = setup_paddles(game, %{y_left: 290})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{x: 1, y: 299})
    expected_game = setup_ball_direction(expected_game, %{x: 1, y: -1})
    expected_game = setup_paddles(expected_game, %{y_left: 290})

    assert expected_game == Physics.update(game)
  end

  test "#update rebounds ball diagonally off top wall and right paddle" do
    game = new_game()
    game = setup_ball_position(game, %{x: 399, y: 299})
    game = setup_ball_direction(game, %{x: 1, y: 1})
    game = setup_paddles(game, %{y_right: 290})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{x: 399, y: 299})
    expected_game = setup_ball_direction(expected_game, %{x: -1, y: -1})
    expected_game = setup_paddles(expected_game, %{y_right: 290})

    assert expected_game == Physics.update(game)
  end

  test "#update rebounds ball diagonally off bottom wall and right paddle" do
    game = new_game()
    game = setup_ball_position(game, %{x: 399, y: 1})
    game = setup_ball_direction(game, %{x: 1, y: -1})
    game = setup_paddles(game, %{y_right: 0})

    expected_game = new_game()
    expected_game = setup_ball_position(expected_game, %{x: 399, y: 1})
    expected_game = setup_ball_direction(expected_game, %{x: -1, y: 1})
    expected_game = setup_paddles(expected_game, %{y_right: 0})

    assert expected_game == Physics.update(game)
  end

  test "#update increments the left score by 1 when the ball attains the right goalline" do
    game = new_game()
    game = setup_ball_position(game, %{x: 399, y: 5})

    %{scores: scores} = Physics.update(game)
    assert %{left: 1, right: 0} == scores
  end

  test "#update centers the ball when it attains the right goalline" do
    game = new_game()
    game = setup_ball_position(game, %{x: 399, y: 5})

    game = Physics.update(game)
    assert %{x: 200, y: 150} == game.ball.position
  end

  test "#update increments the right score by 1 when the ball attains the left goalline" do
    game = new_game()
    game = setup_ball_position(game, %{x: 1, y: 5})
    game = setup_ball_direction(game, %{x: -1, y: 0})

    %{scores: scores} = Physics.update(game)
    assert %{left: 0, right: 1} == scores
  end

  test "#update centers the ball when it attains the left goalline" do
    game = new_game()
    game = setup_ball_position(game, %{x: 1, y: 5})
    game = setup_ball_direction(game, %{x: -1, y: 0})

    game = Physics.update(game)
    assert %{x: 200, y: 150} == game.ball.position
  end

  defp setup_ball_position(game, new_position) do
    %{ball: ball} = game
    new_ball = %{ball | position: Map.merge(ball.position, new_position)}
    %{game | ball: new_ball}
  end

  defp setup_ball_direction(game, new_direction) do
    %{ball: ball} = game
    new_ball = %{ball | direction: Map.merge(ball.direction, new_direction)}
    %{game | ball: new_ball}
  end

  defp setup_paddles(game, new_paddles) do
    %{game | paddles: Map.merge(game.paddles, new_paddles)}
  end

  defp new_game do
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
