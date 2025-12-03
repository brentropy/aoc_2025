ExUnit.start()

defmodule Inputs do
  @root_path File.cwd!()

  def read(name) when is_binary(name) do
    Path.join([@root_path, "priv", "inputs", name])
    |> File.read!()
    |> String.trim()
  end
end
