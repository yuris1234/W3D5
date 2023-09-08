require "byebug"

class PolyTreeNode
    attr_reader :value,:parent,:children
    def initialize(param)
        @value=param
        @parent=nil
        @children=[]
    end

    def parent=(node)
        oldparent=parent
        if oldparent!=nil
            i= oldparent.children.index(self) 
            oldparent.children.delete_at(i)
        end
        @parent=node
    
        parent.children<<self if parent!=nil
    end

    def add_child(node)
        node.parent=(self)
    end

    def remove_child(node)
        raise if node.parent == nil
        node.parent=nil
    end

    def dfs(target)
        #base case
        return self if value == target

        children.each do |child|
            child_node = child.dfs(target)
            return child_node if child_node != nil 
        end
        nil
    end
    def bfs(target)
        queue = [self]
        until queue.empty?
            x = queue.shift
            return x if x.value==target
            queue += x.children
        end
        nil
    end
end
