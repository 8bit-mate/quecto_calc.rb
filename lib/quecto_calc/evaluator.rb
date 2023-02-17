# frozen_string_literal: true

require_relative "quecto_error"
require_relative "token_types"

#
# Evaluates expression from the abstract syntax tree.
#
class Evaluator
  include TokenTypes

  #
  # Initialize an evaluator instance.
  #
  # @param [Hash{ String => Numeric }] consts
  #   List of constants and their values to put in the expression.
  #
  def initialize(consts = {})
    @consts = consts
  end

  #
  # @param [BinOpNode, NumberNode] node
  #
  def visit(node)
    send("_visit_#{node.class}", node)
  end

  private

  #
  # Retrieve result of a binary operation node.
  #
  # @param [BinOpNode] node
  #
  # @return [Numeric]
  #   Result of the binary operation.
  #
  def _visit_BinOpNode(node)
    left = visit(node.left_node)
    right = visit(node.right_node)

    case node.operator.type
    when TT_PLUS
      left + right
    when TT_MINUS
      left - right
    end
  end

  #
  # Retrieve value of a number node.
  #
  # @param [NumberNode] node
  #
  # @return [Numeric]
  #
  def _visit_NumberNode(node)
    case node.token.type
    when TT_INT
      node.token.value
    when TT_CONST
      _init_constant(node)
    end
  end

  #
  # Replace constant with an associated value.
  #
  # @param [NumberNode] node
  #   A numeric node with @token of TT_CONST type.
  #
  # @return [Numeric]
  #
  # @raise [CalcError]
  #   Raises if constant is not found in the @consts.
  #
  def _init_constant(node)
    if @consts.key?(node.token.value)
      @consts[node.token.value]
    else
      error_msg = "undefined constant '#{node.token.value}'"
      raise CalcError, error_msg
    end
  end
end
