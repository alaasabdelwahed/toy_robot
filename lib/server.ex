defmodule Server do
  use Agent

  @moduledoc """
  A module that serves as a server to handle state.
  """

  @doc """
  Starts the server with an initial state of nil
  """
  def start do
    Agent.start_link(fn -> nil end, name: __MODULE__)
  end

  @doc """
  Updates the state by setting the state to the new values passed in
  """
  def update_state(new_state) do
    Agent.update(__MODULE__, fn _ -> new_state end)
  end

  @doc """
  Returns the current state
  """
  def get_state do
    Agent.get(__MODULE__, &(&1))
  end
end
