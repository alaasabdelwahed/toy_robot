defmodule ToyRobotTest do
  use ExUnit.Case
  doctest ToyRobot
  alias Server
  alias ToyRobot

  setup do
    Server.start()
    :ok
  end

  describe "place/3" do
    test "returns the place coordinates if placed in a correct position" do
      assert ToyRobot.place(1, 2, "NORTH") == :ok
    end

    test "returns error if x & y coordinates are invalid" do
      assert ToyRobot.place(5, 2, "NORTH") == "Invalid coordinates or direction"
    end

    test "returns error if direction is invalid" do
      assert ToyRobot.place(5, 2, "XYZ") == "Invalid coordinates or direction"
    end
  end

  describe "move/0" do
    test "ignores orders if not placed" do
      assert ToyRobot.move() == "Robot must be placed on the table first"
    end

    test "returns error if moved outside the table boundaries" do
      ToyRobot.place(4, 4, "NORTH")
      assert ToyRobot.move() == "Robot will fall if moved in this direction"
    end

    test "returns ok if moved within the table boundaries" do
      ToyRobot.place(1, 2, "EAST")
      assert ToyRobot.move() == :ok
    end
  end

  describe "left/0" do
    test "ignores orders if not placed" do
      assert ToyRobot.left() == "Robot must be placed on the table first"
    end

    test "faces west if current position is north" do
      ToyRobot.place(1, 2, "NORTH")
      ToyRobot.left()
      assert Server.get_state() == {1, 2, "WEST"}
    end

    test "faces south if current position is west" do
      ToyRobot.place(1, 2, "WEST")
      ToyRobot.left()
      assert Server.get_state() == {1, 2, "SOUTH"}
    end

    test "faces east if current position is south" do
      ToyRobot.place(1, 2, "SOUTH")
      ToyRobot.left()
      assert Server.get_state() == {1, 2, "EAST"}
    end

    test "faces north if current position is east" do
      ToyRobot.place(1, 2, "EAST")
      ToyRobot.left()
      assert Server.get_state() == {1, 2, "NORTH"}
    end
  end

  describe "right/0" do
    test "ignores orders if not placed" do
      assert ToyRobot.right() == "Robot must be placed on the table first"
    end

    test "faces east if current position is north" do
      ToyRobot.place(1, 2, "NORTH")
      ToyRobot.right()
      assert Server.get_state() == {1, 2, "EAST"}
    end

    test "faces south if current position is east" do
      ToyRobot.place(1, 2, "EAST")
      ToyRobot.right()
      assert Server.get_state() == {1, 2, "SOUTH"}
    end

    test "faces west if current position is south" do
      ToyRobot.place(1, 2, "SOUTH")
      ToyRobot.right()
      assert Server.get_state() == {1, 2, "WEST"}
    end

    test "faces north if current position is west" do
      ToyRobot.place(1, 2, "WEST")
      ToyRobot.right()
      assert Server.get_state() == {1, 2, "NORTH"}
    end
  end

  describe "report/0" do
    test "ignores orders if not placed" do
      assert ToyRobot.report() == "Robot must be placed on the table first"
    end

    test "returns the current position of the robot" do
      ToyRobot.place(1, 2, "WEST")
      assert ToyRobot.report() == "1, 2, WEST"
    end
  end
end
