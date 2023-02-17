# frozen_string_literal: true

#
# Stores a node with a numeric value.
#
class NumberNode
  attr_reader :token

  def initialize(token)
    @token = token
  end
end
