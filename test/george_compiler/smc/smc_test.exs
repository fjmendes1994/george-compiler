defmodule SMCTest do
    @moduledoc false
    alias GeorgeCompiler.SMC, as: SMC
    use ExUnit.Case

    test "Criação do SMC" do
        assert SMC.new == %SMC{
                            c: %Stack{elements: []},
                            m: %{},
                            s: %Stack{elements: []}
                        }
    end

    test "Inserção em S" do
        smc = SMC.new |> SMC.add_value(5)
        assert smc == %SMC{
                            c: %Stack{elements: []},
                            m: %{},
                            s: %Stack{elements: [5]}
                        }
    end
end