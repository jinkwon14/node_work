class PolyTreeNode
  attr_accessor :children
  attr_reader :parent, :value

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(parent)
    unless @parent.nil?
      @parent.children.delete(self)
    end

    @parent = parent
    parent.children << self unless parent.nil?
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child)
    raise if child.parent.nil?
    child.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value

    self.children.each do |child|
      result = child.dfs(target_value)
      return result unless result.nil?
    end

    return nil
  end

  def bfs(target_value)
    queue = [self]
    results = []

    until queue.empty?
      results << (current_node = queue.shift)

      return current_node if current_node.value == target_value

      current_node.children.each do |child|
        queue << child unless queue.include?(child) || results.include?(child)
      end
    end

    return nil
  end
end
