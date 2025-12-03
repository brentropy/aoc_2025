defmodule Aoc.Helpers.Grid.HexVector do
  @moduledoc """
  HexVector is a collection of utility functions for working with 3d Vector
  structs based on [Cube Coordinates](https://www.redblobgames.com/grids/hexagons/#coordinates-cube)
  """
  alias Aoc.Helpers.Grid.Vector

  @pointy_top_directions %{
    "ne" => Vector.at(1, -1, 0),
    "e" => Vector.at(1, 0, -1),
    "se" => Vector.at(0, 1, -1),
    "sw" => Vector.at(-1, 1, 0),
    "w" => Vector.at(-1, 0, 1),
    "nw" => Vector.at(0, -1, 1)
  }

  @flat_top_directions %{
    "n" => Vector.at(0, -1, 1),
    "ne" => Vector.at(1, -1, 0),
    "se" => Vector.at(1, 0, -1),
    "s" => Vector.at(0, 1, -1),
    "sw" => Vector.at(-1, 1, 0),
    "nw" => Vector.at(-1, 0, 1)
  }

  def neighbors(%Vector{} = vector) do
    @pointy_top_directions
    |> Map.values()
    |> Enum.map(&Vector.add(vector, &1))
  end

  def move(%Vector{} = vector, dir, :pointy_top) do
    Vector.add(vector, Map.get(@pointy_top_directions, dir, %Vector{}))
  end

  def move(%Vector{} = vector, dir, :flat_top) do
    Vector.add(vector, Map.get(@flat_top_directions, dir, %Vector{}))
  end

  def surrounding(%Vector{} = vector) do
    neighbors(vector)
  end

  def distance(%Vector{} = a, %Vector{} = b) do
    Vector.distance(a, b) |> div(2)
  end

  def valid?(%Vector{x: x, y: y, z: z}) do
    x + y + z == 0
  end
end
