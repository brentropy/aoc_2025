defmodule Mix.Tasks.Gen.Day do
  use Mix.Task

  @shortdoc "Generate module and test for an AOC problem"

  @moduledoc """
  Generate module and test for an AOC problem

      $ mix gen.day 24

  """

  @root_path File.cwd!()

  def run(args) do
    day = args |> hd() |> String.to_integer()
    generate_files(day)
    IO.puts("https://adventofcode.com/#{Aoc.year()}/day/#{day}")
  end

  defp generate_files(num) do
    module = EEx.eval_file(template_path("day_n.ex"), num: num)
    test = EEx.eval_file(template_path("day_n_test.exs"), num: num)
    input = Aoc.Client.input(num)
    Mix.Generator.create_file(module_path("day_#{num}.ex"), module)
    Mix.Generator.create_file(test_path("day_#{num}_test.exs"), test)
    Mix.Generator.create_file(input_path("day_#{num}_input.txt"), input)
  end

  defp template_path(file) do
    Path.join([@root_path, "priv", "templates", "gen.day", file])
  end

  defp module_path(file) do
    Path.join([@root_path, "lib", "aoc", file])
  end

  defp test_path(file) do
    Path.join([@root_path, "test", "aoc", file])
  end

  defp input_path(file) do
    Path.join([@root_path, "priv", "inputs", file])
  end
end
