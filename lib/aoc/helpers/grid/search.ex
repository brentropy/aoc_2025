defmodule Aoc.Helpers.Grid.Search do
  alias Aoc.Helpers.Grid.Vector
  alias Aoc.Helpers.Grid

  defmacro __using__ do
    quote do
      @behavior Aoc.Helpers.Grid.Search

      def reachable?(grid, _vector, next, _came_from) do
        !!Grid.get(grid, next)
      end

      def cost(_grid, _vector, _next, _prev, _came_from), do: 1

      defdelegate neighbors(grid, vector), to: Aoc.Helpers.Grid

      defoverridable reachable?: 4, cost: 5, neighbors: 2
    end
  end

  @callback reachable(
              grid :: Grid.t(),
              pos :: Vector.t(),
              next :: Vector.t(),
              came_from :: %{Vector.t() => [Vector.t(), ...]}
            ) :: boolean()

  @callback cost(
              grid :: Grid.t(),
              pos :: Vector.t(),
              next :: Vector.t(),
              prev :: Vector.t(),
              came_from :: %{Vector.t() => [Vector.t(), ...]}
            ) :: number()

  @callback neighbors(
              grid :: Grid.t(),
              pos :: Vector.t()
            ) :: [Vector.t()]
end
