defmodule Aoc.Helpers do
  def sign(0), do: 0
  def sign(n) when n < 0, do: -1
  def sign(_), do: 1

  def divisors(n) do
    1..trunc(:math.sqrt(n))
    |> Stream.filter(&(rem(n, &1) == 0))
    |> Stream.flat_map(fn i -> Enum.dedup([i, div(n, i)]) end)
  end

  def lcm(a, b), do: div(abs(a * b), Integer.gcd(a, b))

  def permutations(list, n, opts \\ [])
  def permutations([], _n, _opts), do: [[]]
  def permutations(_list, 0, _opts), do: [[]]

  def permutations(list, n, opts) do
    repeats = Keyword.get(opts, :repeats, false)

    for head <-
          list,
        tail <-
          permutations(if(repeats, do: list, else: list -- [head]), n - 1),
        do: [head | tail]
  end

  def combinations(_, 0), do: [[]]
  def combinations([], _), do: []

  def combinations([head | tail], n) do
    for(l <- combinations(tail, n - 1), do: [head | l]) ++ combinations(tail, n)
  end
end
