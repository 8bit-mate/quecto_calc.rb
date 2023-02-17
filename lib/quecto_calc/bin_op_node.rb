# frozen_string_literal: true

#
# Stores a node with a binary operation (between two numbers).
#
class BinOpNode
  attr_reader :left_node, :operator, :right_node

  def initialize(left_node, operator, right_node)
    @left_node = left_node
    @operator = operator
    @right_node = right_node
  end
end
