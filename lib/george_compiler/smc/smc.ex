defmodule GeorgeCompiler.SMC do
    import GeorgeCompiler.SMC.Arit
    import GeorgeCompiler.SMC.Bool
    import GeorgeCompiler.SMC.Control

    def evaluate(s, m, c) do
        if Stack.depth(c) > 0 do
            {node, c} = Stack.pop(c)
            {s, m, c} = do_operation(node, s, m, c)
            evaluate(s, m, c)
        else
            {s, m, c}
        end
    end

    def do_operation(node, s, m, c) do
        if Tree.is_leaf node do 
            modify_s(node, s, m, c)
        else
            {s, m, decompose_tree(node, c)}
        end
    end

    defp decompose_tree(tree, c) do
        cond do
            is_arit_exp(tree.value) -> arit_decompose_tree(tree, c)
            is_bool_exp(tree.value) -> bool_decompose_tree(tree, c)
            is_control(tree.value) -> control_decompose_tree(tree, c)
        end
    end

    defp modify_s(node, s, m, c) do
        if is_value node.value do
            {Stack.push(s,node.value), m, c} 
        else
            s = get_operation(node.value)
                |> apply_operation(node.value, s, m, c)
            {s, m, c}
        end
    end

    defp is_value(value) do
        not (is_arit_exp(value) or is_bool_exp(value) or is_control(value)) 
    end

    defp get_operation(operation) do
        cond do
            is_arit_exp(operation) -> &artit_exp/2
            is_bool_exp(operation) -> &bool_exp/2
            is_control(operation) -> &control/3
        end
    end

    defp apply_operation(function, operation, s, m, c) do
        function.(operation, s)
    end
end
