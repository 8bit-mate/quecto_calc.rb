# frozen_string_literal: true

require "quecto_parser"

require_relative "quecto_calc/evaluator"
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
  #
  # Evaluate an expression.
  #
  # @param [String] expr
  #   Expression (in a text form) to parse and evaluate.
  #
  # @option [Hash{ String => Numeric }] consts
  #   List on constants and their values to put in the expression.
  #
  def evaluate(expr, consts = {})
    parser = QuectoParser.new

    ast = parser.parse_expr(expr)
    evaluate_ast(ast, consts) if ast
  end

  #
  # Evaluate expression from the AST.
  #
  # @param [QuectoParser::NumberNode, QuectoParser::BinOpNode] ast
  #   Expression (in a form of AST) to evaluate.
  #
  # @option [Hash{ String => Numeric }] consts
  #   List on constants and their values to put in the expression.
  #
  def evaluate_ast(ast, consts = {})
    evaluator = Evaluator.new(consts)
    evaluator.visit(ast)
  rescue QuectoCalcError, NoMethodError => e
    puts "[#{e.class}] #{e.message}"
  end
end
