# frozen_string_literal: true

#
# Provides character rules that are used by the lexer.
#
module CharRules
  NUM_CHAR = /[[:digit:]]/.freeze # characters that could form a number: digits only
  CONST_FIRST_CHAR = /[[:alpha:]]/.freeze # characters that could be used as a 1st char. in the constant name
  CONTS_CHAR = /[[:alpha:][:digit:]_]/.freeze # characters that could form a constant: letters, digits, underscore char.

  ADD_CHAR = "+"  # character that marks an addition operator
  SUB_CHAR = "-"  # character that marks an subtraction operator

  IGNOR_CHAR = /\s/.freeze # characters that are ignored: all whitespace
end
