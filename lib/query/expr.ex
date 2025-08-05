defmodule Query.Expr do
  @type t_simple_operand() :: {:property, binary(), binary()} | {:string, binary()}

  @type t_simple() ::
          {:eq, Query.Expr.t_simple_operand(), Query.Expr.t_simple_operand()}
          | {:geq, Query.Expr.t_simple_operand(), Query.Expr.t_simple_operand()}
          | {:leq, Query.Expr.t_simple_operand(), Query.Expr.t_simple_operand()}
          | {:gt, Query.Expr.t_simple_operand(), Query.Expr.t_simple_operand()}
          | {:lt, Query.Expr.t_simple_operand(), Query.Expr.t_simple_operand()}

  @type t() ::
          Query.Expr.t_simple()
          | {:and, Query.Expr.t(), Query.Expr.t()}
          | {:or, Query.Expr.t(), Query.Expr.t()}
end
