defmodule ToyRobot do
  alias Server

  @moduledoc """
  ToyRobot is a module that handles functionality for moving a toy
  robot on a surface table.
  """

  @directions ["NORTH", "EAST", "SOUTH", "WEST"]

  @doc """
  Takes in the x & y coordinates of the robot and the
  direction it's facing and sets the initial state.
  The state is a 3 element tuple containing:
  {x-coordinate, y-coordinate, direction-of-robot}
  """
  def place(x, y, direction) do
    with :ok <- validate_coordinates(x, y),
         :ok <- validate_direction(direction)
    do
      Server.update_state({x, y, direction})
    else
      :error -> "Invalid coordinates or direction"
    end
  end

  @doc """
  Checks if the robot has been placed.
  If placed, changes the direction of the robot to the left
  of it's currect direction
  Otherwise, returns an error.
  """
  def left do
    case Server.get_state() do
      nil -> "Robot must be placed on the table first"
      {x, y, direction} -> Server.update_state({x, y, change_direction(direction, :left)})
    end
  end

  @doc """
  Checks if the robot has been placed.
  If placed, changes the direction of the robot to the right
  of it's currect direction
  Otherwise, returns an error.
  """
  def right do
    case Server.get_state() do
      nil -> "Robot must be placed on the table first"
      {x, y, direction} -> Server.update_state({x, y, change_direction(direction, :right)})
    end
  end

  @doc """
  Moves the robot 1 step in the direction the robot is facing.
  If the robot exceeds the limits of the table, it doesn't update
  the state and returns an error instead.
  Otherwise, it updates the state with the new coordinates.
  """
  def move do
    case Server.get_state() do
      nil -> "Robot must be placed on the table first"
      state -> execute_move(state)
    end
  end

  defp execute_move({x, y, direction}) do
    {new_x, new_y} = move_in_direction(direction, x, y)
    case validate_coordinates(new_x, new_y) do
      :error -> "Robot will fall if moved in this direction"
      :ok -> Server.update_state({new_x, new_y, direction})
    end
  end

  @doc """
  Returns the current position of the robot
  """
  def report do
    case Server.get_state() do
      nil -> "Robot must be placed on the table first"
      {x, y, direction} -> "#{x}, #{y}, #{direction}"
    end
  end

  #-----------------
  # Private Helpers
  #-----------------
  defp validate_coordinates(x, y) when x < 0 or y < 0, do: :error
  defp validate_coordinates(x, y) when x > 4 or y > 4, do: :error
  defp validate_coordinates(_, _), do: :ok

  defp validate_direction(direction) do
    case Kernel.in(direction, @directions) do
      true -> :ok
      false -> :error
    end
  end

  defp change_direction(current_direction, :left) do
    current_direction
    |> locate
    |> rotate_left
  end
  defp change_direction(current_direction, :right) do
    current_direction
    |> locate
    |> rotate_right
  end

  defp locate(current_direction),
    do: Enum.find_index(@directions, &(&1) == current_direction)

  defp rotate_left(0), do: Enum.at(@directions, 3)
  defp rotate_left(index), do: Enum.at(@directions, index - 1)

  defp rotate_right(3), do: Enum.at(@directions, 0)
  defp rotate_right(index), do: Enum.at(@directions, index + 1)

  defp move_in_direction("NORTH", x, y), do: {x, y + 1}
  defp move_in_direction("EAST", x, y), do: {x + 1, y}
  defp move_in_direction("SOUTH", x, y), do: {x, y - 1}
  defp move_in_direction("WEST", x, y), do: {x - 1, y}
end
