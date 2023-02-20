# frozen_string_literal: true

#
# Errors rised by the quecto_calc.
#
class QuectoCalcError < ::StandardError
  attr_reader :message

  def initialize(message)
    @message = message
    super()
  end
end

#
# Raised by the evaluator on an illegal operation.
#
class CalcError < QuectoCalcError
  attr_reader :message

  def initialize(message = "")
    super(message)
  end
end
