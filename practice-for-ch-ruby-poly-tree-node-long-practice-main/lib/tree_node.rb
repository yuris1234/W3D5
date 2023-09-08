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
            child_value = child.dfs(target)
            return child_value if child_value == target 
        end

        nil
    end
end
