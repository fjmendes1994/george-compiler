defmodule GeorgeCompiler do
  @moduledoc """
   Compilador Geroge
  """

  GeorgeCompiler.Parser.parse("10 + -20 - 30 / 40 * 50 % 60") |> IO.inspect()

end
