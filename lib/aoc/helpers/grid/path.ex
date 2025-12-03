defmodule Aoc.Helpers.Grid.Path do
  alias Aoc.Helpers.Grid.Vector
  alias Aoc.Helpers.Grid

  defmodule DefaultRules do
    def reachable?(grid, _vector, next, _came_from), do: !!Grid.get(grid, next)
    def cost(_grid, _vector, _next, _came_from), do: 1
    defdelegate heuristic(grid, vector, goal), to: Grid, as: :distance
    defdelegate neighbors(grid, vector), to: Grid
  end

  def find(
        %Grid{} = grid,
        %Vector{} = start,
        %Vector{} = goal,
        rules \\ DefaultRules
      ) do
    frontier = Heap.new() |> Heap.push({0, start})
    came_from = %{start => nil}
    cost_so_far = %{start => 0}
    find_next(grid, goal, rules, {frontier, came_from, cost_so_far})
  end

  defp find_next(
         %Grid{} = grid,
         goal,
         rules,
         {frontier, came_from, cost_so_far}
       ) do
    case Heap.split(frontier) do
      {nil, _} ->
        {:unreachable, came_from, cost_so_far}

      {{_, ^goal}, _} ->
        {:ok, cost_so_far[goal], path_to(came_from, goal)}

      {{_, current}, rest_frontier} ->
        next_state =
          rules.neighbors(grid, current)
          |> Enum.map(&elem(&1, 0))
          |> Enum.filter(&rules.reachable?(grid, current, &1, came_from))
          |> Enum.reduce(
            {rest_frontier, came_from, cost_so_far},
            fn next, {frontier_acc, came_from_acc, cost_so_far_acc} = acc ->
              new_cost =
                cost_so_far[current] +
                  rules.cost(grid, current, next, came_from)

              if Map.has_key?(cost_so_far, next) and
                   new_cost >= cost_so_far[next] do
                acc
              else
                priority = new_cost + rules.heuristic(grid, next, goal)

                {
                  Heap.push(frontier_acc, {priority, next}),
                  Map.put(came_from_acc, next, current),
                  Map.put(cost_so_far_acc, next, new_cost)
                }
              end
            end
          )

        find_next(grid, goal, rules, next_state)
    end
  end

  defp path_to(came_from, vector, path \\ []) do
    if came_from[vector] == nil do
      path
    else
      path_to(came_from, came_from[vector], [vector | path])
    end
  end

  def find_all(grid, start_pos, end_pos, allowed, max_length) do
    find_all_next(grid, allowed, start_pos, end_pos, max_length, [start_pos])
  end

  def find_all_next(_, _, cur_pos, end_pos, _, path) when cur_pos == end_pos do
    [Enum.reverse(path)]
  end

  def find_all_next(grid, allowed, cur_pos, end_pos, max_length, path) do
    if Enum.count(path) >= max_length do
      []
    else
      grid
      |> Grid.neighbors(cur_pos)
      |> Enum.reject(fn {next_pos, _} -> next_pos in path end)
      |> Enum.filter(fn {pos, val} -> pos == end_pos or val in allowed end)
      |> Enum.map(fn {next_pos, _} -> [next_pos | path] end)
      |> Enum.flat_map(fn next_path ->
        find_all_next(
          grid,
          allowed,
          hd(next_path),
          end_pos,
          max_length,
          next_path
        )
      end)
    end
  end
end
