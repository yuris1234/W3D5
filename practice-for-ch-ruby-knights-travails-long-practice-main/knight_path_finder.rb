require "byebug"
require_relative "./poly_tree_node.rb"

class KnightPathFinder
    attr_reader :pos, :considered_positions, :initial_pos

    def self.valid_moves(pos)
        result=[]
        valid =[[1,2],[2,1],[-2,1],[1,-2],[-2,-1],[-1,-2],[2,-1],[-1,2]]
        valid.each do |sub|
            result<<self.new_pos(pos, sub) if self.valid_pos(pos,sub)
        end
        result
    end

    def self.valid_pos(pos,move)
        pos = self.new_pos(pos,move)
        return true if (0..7).include?(pos[0]) && (0..7).include?(pos[1])
        false
    end

    def self.new_pos(pos, move)
        new_pos=[]
        new_pos<<pos[0]+move[0]
        new_pos<<pos[1]+move[1]
        return new_pos 
    end

    def initialize(pos)
        @end_pos = pos
        @considered_positions = [pos]
        @root_node = PolyTreeNode.new(pos)
    end

    def new_move_positions(pos)
        valid = KnightPathFinder.valid_moves(pos).reject {|ele| @considered_positions.include?(ele)}
        @considered_positions+=valid
        valid
    end

    def build_move_tree
        
    end

end

# k = KnightPathFinder.new([0,0])
# p KnightPathFinder.valid_moves([0,0])
# p KnightPathFinder.valid_moves([7,7])
# p k.new_move_positions([-1,7])