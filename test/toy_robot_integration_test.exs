defmodule ToyRobotIntegrationTest do
  use ExUnit.Case
  doctest ToyRobot
  alias Server
  alias ToyRobot

  setup do
    Server.start()
    :ok
  end

  describe "coding test example a" do
    test "produces 0, 1, NORTH" do
      ToyRobot.place(0, 0, "NORTH")
      ToyRobot.move()
      assert ToyRobot.report() == "0, 1, NORTH"
    end
  end

  describe "coding test example b" do
    test "produces 0, 0, WEST" do
      ToyRobot.place(0, 0, "NORTH")
      ToyRobot.left()
      assert ToyRobot.report() == "0, 0, WEST"
    end
  end

  describe "coding test example c" do
    test "produces 3, 3, NORTH" do
      ToyRobot.place(1, 2, "EAST")
      ToyRobot.move()
      ToyRobot.move()
      ToyRobot.left()
      ToyRobot.move()
      assert ToyRobot.report() == "3, 3, NORTH"
    end
  end
end
