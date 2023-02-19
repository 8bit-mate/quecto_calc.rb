# frozen_string_literal: true

require_relative "quecto_calc/evaluator"
require_relative "quecto_calc/const_interface"
require_relative "quecto_calc/lexer"
require_relative "quecto_calc/parser"
require_relative "quecto_calc/version"

#
# A simple calculator that evaluates primitive arithmetic expressions represented in a text form.
#
# Supported operators:
#   + -- add a number
#   - -- subtract a number.
#
# Supported types:
#   Integer;
#   Constant (a string placeholder for an Integer).
#
# Parser/lexer stuff was inspired by the David Callanan's "Make Your Own Programming Language" series
# @ https://github.com/davidcallanan/py-myopl-code
#
class QuectoCalc
  include ConstInterface

  #
  # Evaluate an expression.
  #
  # @param [String] expr
  #   Expression to parse and evaluate.
  #
  # @option [Hash{ String => Numeric }] consts
  #   List on constants and their values to put in the expression.
  #
  def evaluate(expr, consts = {})
    tokens = build_tokens(expr)
    ast = build_ast(tokens)
    evaluate_ast(ast, consts)
  rescue QuectoError => e
    puts "#{e.error_name} #{e.message}"
  end

  #
  # Get a list of tokens from the string.
  #
  # @param [String] expr
  #
  def build_tokens(expr)
    Lexer.new(expr).build_tokens
  end

  #
  # Build an abstract syntax tree from a list of tokens.
  #
  # @param [Array<Token>] tokens
  #
  def build_ast(tokens)
    Parser.new(tokens).parse
  end

  #
  # Evaluate expression from the AST.
  #
  # @param [NumberNode, BinOpNode] ast
  #   Expression (in a form of AST) to evaluate.
  #
  # @option [Hash{ String => Numeric }] consts
  #   List on constants and their values to put in the expression.
  #
  def evaluate_ast(ast, consts = {})
    evaluator = Evaluator.new(consts)
    evaluator.visit(ast)
  end
end
