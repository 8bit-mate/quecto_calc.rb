# frozen_string_literal: true

#
# Provides supported token types.
#
module TokenTypes
  TT_INT = :TT_INT     # integer number
  TT_CONST = :TT_CONST # constant (placeholder for a numeric value)
  TT_PLUS = :TT_PLUS   # addition operator
  TT_MINUS = :TT_MINUS # subtraction operator
  TT_EOF = :TT_EOF     # end of input

  TERMS = [TT_INT, TT_CONST].freeze

  BIN_OPS = [TT_PLUS, TT_MINUS].freeze
end
