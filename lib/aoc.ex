defmodule Aoc do
  def year do
    Application.fetch_env!(:aoc, :year)
  end
end
