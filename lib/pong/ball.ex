defmodule Pong.Ball do
  def move(%{position: position, direction: direction} = ball) do
    new_position = %{
      x: position.x + direction.x,
      y: position.y + direction.y,
    }
    update_position ball, new_position
  end

  def update_position(%{position: position} = ball, new_position) do
    %{ball | position: Map.merge(position, new_position)}
  end

  def inverse_x_direction(%{direction: direction} = ball) do
    new_x = %{x: -direction.x}
    %{ball | direction: Map.merge(direction, new_x)}
  end

  def inverse_y_direction(%{direction: direction} = ball) do
    new_y = %{y: -direction.y}
    %{ball | direction: Map.merge(direction, new_y)}
  end
end
