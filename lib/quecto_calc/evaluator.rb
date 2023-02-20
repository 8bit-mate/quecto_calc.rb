# frozen_string_literal: true

require_relative "quecto_calc_error"

#
# Evaluates expression from the abstract syntax tree.
#
class Evaluator
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
  # @param [QuectoParser::BinOpNode, QuectoParser::NumberNode] node
  #
  def visit(node)
    method_name = "_visit_#{node.class}"
    send(method_name, node)
  end

  #
  # @param [String] _method_name
  #
  # @param [Object] node
  #
  # @raise [NoMethodError]
  #
  def method_missing(_method_name, node)
    error_msg = "unsupported node type: #{node.class}. Plase check parser's output for correct node types."
    raise NoMethodError, error_msg
  end

  def respond_to_missing?(*)
    true
  end

  private

  #
  # Retrieve result of a binary operation node.
  #
  # @param [QuectoParser::BinOpNode] node
  #
  # @return [Numeric]
  #   Result of the binary operation.
  #
  def _visit_BinOpNode(node)
    left = visit(node.left_node)
    right = visit(node.right_node)

    case node.operator.type
    when TokenTypes::TT_PLUS
      left + right
    when TokenTypes::TT_MINUS
      left - right
    end
  end

  #
  # Retrieve value of a number node.
  #
  # @param [QuectoParser::NumberNode] node
  #
  # @return [Numeric]
  #
  def _visit_NumberNode(node)
    case node.token.type
    when TokenTypes::TT_INT
      node.token.value
    when TokenTypes::TT_CONST
      _init_constant(node)
    end
  end

  #
  # Replace constant with an associated value.
  #
  # @param [QuectoParser::NumberNode] node
  #   A numeric node with @token of TT_CONST type.
  #
  # @return [Numeric]
  #
  # @raise [CalcError::RunTimeError]
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
