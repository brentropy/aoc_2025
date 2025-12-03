defmodule Aoc.Client do
  defp client do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://adventofcode.com/#{Aoc.year()}"},
      {Tesla.Middleware.Headers, [{"cookie", cookie()}]}
    ]

    Tesla.client(middleware)
  end

  defp cookie do
    Application.fetch_env!(:aoc, :cookie)
  end

  def input(day) do
    response = Tesla.get!(client(), "/day/#{day}/input")

    String.trim(response.body)
  end
end
