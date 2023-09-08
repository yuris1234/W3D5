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
            p oldparent.children
            oldparent.children.delete_at(i)
            p oldparent.children
        end
        @parent=node
    
        parent.children<<self if parent!=nil
    end
  
end