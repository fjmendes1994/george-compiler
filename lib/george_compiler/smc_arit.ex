defmodule GeorgeCompiler.SMC.Arit do
    @operations %{"add" => &Arit.add/1, "sub" => &Arit.sub/1}

    def artit_exp(operation,s) do
        expression = @operations[operation]
        expression.(s)
    end

    def add(s)do
        {x,s} = Stack.pop(s)
        {y,s} = Stack.pop(s)
        Stack.push(s, x+y)
    end

    def sub(s)do
        {x,s} = Stack.pop(s)
        {y,s} = Stack.pop(s)
        Stack.push(s, x-y)
    end

    def is_arit_exp(operation), do: Enum.member? @operations, operation
end