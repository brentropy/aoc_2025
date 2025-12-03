defmodule Aoc.Helpers.Grid do
  @moduledoc """
  A 3-dimensional grid type that can expand infinitely in any direction.
  `Grid` implements the `Enumerable` and `Collectable` protocols.
  """

  alias __MODULE__
  alias Aoc.Helpers.Grid.Vector

  defstruct system: Vector,
            cells: %{},
            min_x: nil,
            max_x: nil,
            min_y: nil,
            max_y: nil,
            min_z: nil,
            max_z: nil,
            default: nil

  @opaque t(value) :: %__MODULE__{
            system: module(),
            cells: %{Vector.t() => value},
            min_x: integer(),
            max_x: integer(),
            min_y: integer(),
            max_y: integer(),
            min_z: integer(),
            max_z: integer(),
            default: value
          }

  @opaque t() :: t(term())

  def new(), do: new(Vector)

  def new(system) do
    %Grid{system: system}
  end

  def parse(str, opts \\ []) do
    split_on = Keyword.get(opts, :split_on, ~r"\s+")

    str
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, split_on, trim: true))
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {cell, x} -> {Vector.at(x, y), cell} end)
    end)
    |> Enum.into(Grid.new())
  end

  def start(value) do
    Grid.put(%Grid{}, %Vector{}, value)
  end

  def get(%Grid{} = grid, %Vector{} = vector) do
    Map.get(grid.cells, vector, grid.default)
  end

  def put(%Grid{} = grid, %Vector{x: x, y: y, z: z} = vector, value) do
    %{
      grid
      | cells: Map.put(grid.cells, vector, value),
        min_x: min(grid.min_x, x),
        max_x: if(grid.max_x, do: max(grid.max_x, x), else: x),
        min_y: min(grid.min_y, y),
        max_y: if(grid.max_y, do: max(grid.max_y, y), else: y),
        min_z: min(grid.min_z, z),
        max_z: if(grid.max_z, do: max(grid.max_z, z), else: z)
    }
  end

  def update(%Grid{} = grid, vec, initial, update_fn) do
    value = Grid.get(grid, vec)

    if value == grid.default do
      put(grid, vec, initial)
    else
      put(grid, vec, update_fn.(value))
    end
  end

  def width(%Grid{min_x: min_x, max_x: max_x}), do: max_x - min_x + 1

  def height(%Grid{min_y: min_y, max_y: max_y}), do: max_y - min_y + 1

  def depth(%Grid{min_z: min_z, max_z: max_z}), do: max_z - min_z + 1

  def size(%Grid{} = grid), do: width(grid) * height(grid) * depth(grid)

  def slice(%Grid{} = grid, %Vector{} = start_at, %Vector{} = end_at) do
    %{
      grid
      | min_x: min(start_at.x, end_at.x),
        max_x: max(start_at.x, end_at.x),
        min_y: min(start_at.y, end_at.y),
        max_y: max(start_at.y, end_at.y),
        min_z: min(start_at.z, end_at.z),
        max_z: max(start_at.z, end_at.z)
    }
  end

  def slice(%Grid{} = grid, %Vector{} = start_at, width, height, depth \\ 1) do
    slice(
      grid,
      start_at,
      Vector.add(start_at, Vector.at(width - 1, height - 1, depth - 1))
    )
  end

  def cols(%Grid{} = grid, z \\ 0) do
    grid.min_x..grid.max_x
    |> Stream.map(
      &slice(
        grid,
        Vector.at(&1, grid.min_y, z),
        Vector.at(&1, grid.max_y, z)
      )
    )
  end

  def rows(%Grid{} = grid, z \\ 0) do
    grid.min_y..grid.max_y
    |> Stream.map(
      &slice(
        grid,
        Vector.at(grid.min_x, &1, z),
        Vector.at(grid.max_x, &1, z)
      )
    )
  end

  def values(%Grid{} = grid) do
    Enum.map(grid, &elem(&1, 1))
  end

  def to_list(%Grid{} = grid), do: Enum.to_list(grid)

  def neighbors(%Grid{} = grid, %Vector{} = vector, opts \\ []) do
    diagonal = Keyword.get(opts, :diagonal, false)

    pos_fun =
      if diagonal do
        fn vector -> grid.system.surrounding(vector) end
      else
        fn vector -> grid.system.neighbors(vector) end
      end

    pos_fun.(vector)
    |> Enum.filter(&grid.system.within(&1, grid))
    |> Enum.map(fn n_pos -> {n_pos, get(grid, n_pos)} end)
  end

  def distance(%Grid{system: system}, %Vector{} = a, %Vector{} = b) do
    system.distance(a, b)
  end

  def trim(%Grid{cells: cells} = grid) do
    trimmed =
      cells
      |> Enum.filter(fn {vector, _} ->
        grid.system.within(vector, grid)
      end)
      |> Enum.into(%{})

    %{grid | cells: trimmed}
  end

  def expand(%Grid{} = grid, %Vector{} = by) do
    %{
      grid
      | min_x: grid.min_x - by.x,
        max_x: grid.max_x + by.x,
        min_y: grid.min_y - by.y,
        max_y: grid.max_y + by.y,
        min_z: grid.min_z - by.z,
        max_z: grid.max_z + by.z
    }
  end

  def with_default(%Grid{} = grid, default) do
    %{grid | default: default}
  end

  def viz(%Grid{} = grid, opts \\ []) do
    formatter = Keyword.get(opts, :formatter, &to_string/1)
    width = Keyword.get(opts, :width, 5)
    divider = Keyword.get(opts, :divider, "|")
    z = Keyword.get(opts, :z, 0)

    grid
    |> rows(z)
    |> Enum.map(fn row ->
      row
      |> Enum.map(&elem(&1, 1))
      |> Enum.map(formatter)
      |> Enum.map(&String.pad_trailing(&1, width))
      |> Enum.join(divider)
    end)
    |> Enum.join("\n")
  end

  def fill(grid, value) do
    grid
    |> Enum.map(fn {vector, _} -> {vector, value} end)
    |> Enum.into(new())
  end

  defimpl Enumerable do
    def count(grid) do
      {:ok, Grid.size(grid)}
    end

    def reduce(grid, acc, fun) do
      reduce(grid, grid.min_x, grid.min_y, grid.min_z, acc, fun)
    end

    def reduce(_grid, _x, _y, _z, {:halt, acc}, _fun) do
      {:halted, acc}
    end

    def reduce(grid, x, y, z, {:suspend, acc}, fun) do
      {:suspended, acc, &reduce(grid, x, y, z, &1, fun)}
    end

    def reduce(grid, x, y, z, {:cont, acc}, fun) when x > grid.max_x do
      reduce(grid, grid.min_x, y + 1, z, {:cont, acc}, fun)
    end

    def reduce(grid, _x, y, z, {:cont, acc}, fun) when y > grid.max_y do
      reduce(grid, grid.min_x, grid.min_y, z + 1, {:cont, acc}, fun)
    end

    def reduce(grid, _x, _y, z, {:cont, acc}, _fun) when z > grid.max_z do
      {:done, acc}
    end

    def reduce(_grid, nil, nil, nil, {:cont, acc}, _fun), do: {:don, acc}

    def reduce(grid, x, y, z, {:cont, acc}, fun) do
      vector = Vector.at(x, y, z)

      reduce(
        grid,
        x + 1,
        y,
        z,
        fun.({vector, Grid.get(grid, vector)}, acc),
        fun
      )
    end

    def member?(_grid, _cell) do
      {:error, Grid}
    end

    def slice(_grid) do
      {:error, Grid}
    end
  end

  defimpl Collectable do
    def into(grid) do
      fun = fn
        grid_acc, {:cont, {vector, value}} ->
          Grid.put(grid_acc, vector, value)

        grid_acc, :done ->
          grid_acc

        _grid_acc, :halt ->
          :ok
      end

      {grid, fun}
    end
  end
end
