defmodule Mix.Tasks.Inputs.Get do
  use Mix.Task

  @shortdoc "Download all inputs for existing solutions"

  @moduledoc """
  Download all inputs for existing solutions

      $ mix inputs.get

  """

  @root_path File.cwd!()

  def run(_) do
    create_missing_inputs()
  end

  defp solution_days do
    MapSet.new(matches_in_dir(module_dir(), ~r"^day_(\d{1,2}).ex$"))
  end

  defp input_days do
    MapSet.new(matches_in_dir(input_dir(), ~r"^day_(\d{1,2})_input.txt$"))
  end

  defp matches_in_dir(dir, regex) do
    case File.ls(dir) do
      {:ok, files} ->
        files
        |> Enum.map(&Regex.run(regex, &1))
        |> Enum.reject(&(&1 == nil))
        |> Enum.map(fn [_, day] -> day end)

      {:error, _} ->
        []
    end
  end

  defp create_missing_inputs do
    MapSet.new(solution_days())
    |> MapSet.difference(MapSet.new(input_days()))
    |> Enum.map(&generate_file/1)
  end

  defp generate_file(num) do
    input = Aoc.Client.input(num)
    file = input_path("day_#{num}_input.txt")
    Mix.Generator.create_file(file, input)
  end

  defp module_dir do
    Path.join([@root_path, "lib", "aoc"])
  end

  defp input_dir do
    Path.join([@root_path, "priv", "inputs"])
  end

  defp input_path(file) do
    Path.join([input_dir(), file])
  end
end
