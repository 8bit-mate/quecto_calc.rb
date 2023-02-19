# frozen_string_literal: true

require_relative "token_types"

#
# Provides an interface to retrieve token types constants to the outer world.
#
module ConstInterface
  include TokenTypes

  def tt_int
    TT_INT
  end

  def tt_const
    TT_CONST
  end

  def tt_plus
    TT_PLUS
  end

  def tt_minus
    TT_MINUS
  end

  def tt_eof
    TT_EOF
  end
end
