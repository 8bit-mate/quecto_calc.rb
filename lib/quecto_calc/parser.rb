# frozen_string_literal: true

require_relative "bin_op_node"
require_relative "number_node"
require_relative "quecto_error"
require_relative "token_types"

#
# Parses list of tokens to build an abstract syntax tree.
#
class Parser
  include TokenTypes

  #
  # Initialize a parser instance.
  #
  # @param [Array<Token>] tokens
  #   List of tokens to parse.
  #
  def initialize(tokens)
    @tokens = tokens
    @cur_token = @tokens[0]
    @idx = 0
  end

  #
  # Parse list of tokens.
  #
  def parse
    _expr
  end

  private

  #
  # Buid a node for the expression.
  #
  # @return [BinOpNode, NumberNode] left
  #   Node for an expression. The left.class corresponds to the expression type: a single number or a binary operation
  #   (an operation between two numbers).
  #
  def _expr
    # retrieve left part of the expression:
    left = _term

    while BIN_OPS.include?(@cur_token.type)
      # retrieve operator between two number nodes:
      op_tok = @cur_token

      # retrieve right part of the expression:
      _next_token
      right = _term

      left = BinOpNode.new(left, op_tok, right)
    end

    left
  end

  #
  # Search for a term in the expression.
  #
  # @return [NumberNode] token
  #   Found term.
  #
  # @raise [InvalidSyntaxError]
  #
  def _term
    if TERMS.include?(@cur_token.type)
      token = NumberNode.new(@cur_token)
    else
      error_msg = "expected TT_INT or TT_LBL, but got #{@cur_token.type}"
      raise InvalidSyntaxError, error_msg
    end

    _next_token
    token
  end

  #
  # Process next token.
  #
  def _next_token
    @idx += 1
    @cur_token = @tokens[@idx] if @idx < @tokens.length
  end
end
