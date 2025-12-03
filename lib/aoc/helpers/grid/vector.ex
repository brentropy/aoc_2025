defmodule Aoc.Helpers.Grid.Vector do
  @moduledoc """
  Vector struct and related functions for working with three-dimensional vectors
  on a Grid.
  """

  alias __MODULE__
  alias Aoc.Helpers.Grid

  defstruct x: 0, y: 0, z: 0

  @type t :: %__MODULE__{
          x: integer(),
          y: integer(),
          z: integer()
        }

  @spec at(integer(), integer(), integer()) :: t()

  def at(x, y, z \\ 0), do: %Vector{x: x, y: y, z: z}

  @spec at({integer(), integer()}) :: t()

  def at({x, y}), do: at(x, y)

  @spec at({integer(), integer(), integer()}) :: t()

  def at({x, y, z}), do: at(x, y, z)

  @spec neighbors(t()) :: [t()]

  def neighbors(%Vector{x: x, y: y, z: z}) do
    [
      at(x, y - 1, z),
      at(x, y + 1, z),
      at(x - 1, y, z),
      at(x + 1, y, z),
      at(x, y, z - 1),
      at(x, y, z + 1)
    ]
  end

  @spec surrounding(t()) :: [t()]

  def surrounding(%Vector{x: x, y: y, z: z} = vector) do
    for sx <- (x - 1)..(x + 1),
        sy <- (y - 1)..(y + 1),
        sz <- (z - 1)..(z + 1),
        (surrounding_vector = at(sx, sy, sz)) != vector,
        do: surrounding_vector
  end

  @spec distance(t(), t()) :: integer()

  def distance(%Vector{} = a, %Vector{} = b) do
    abs(a.x - b.x) + abs(a.y - b.y) + abs(a.z - b.z)
  end

  @spec within(t(), Grid.t()) :: boolean()

  def within(%Vector{x: x, y: y, z: z}, %Grid{} = grid) do
    x >= grid.min_x && x <= grid.max_x &&
      y >= grid.min_y && y <= grid.max_y &&
      z >= grid.min_z && z <= grid.max_z
  end

  @spec add(t(), t()) :: t()

  def add(%Vector{x: ax, y: ay, z: az}, %Vector{x: bx, y: by, z: bz}) do
    at(ax + bx, ay + by, az + bz)
  end

  @spec diff(t(), t()) :: t()

  def diff(%Vector{} = a, %Vector{} = b) do
    at(a.x - b.x, a.y - b.y, a.z - b.z)
  end

  @spec mul(t(), integer()) :: t()

  def mul(%Vector{x: x, y: y, z: z}, n) do
    at(x * n, y * n, z * n)
  end
end
