require "byebug"
require_relative "./poly_tree_node.rb"

class KnightPathFinder
    attr_reader :start_pos, :considered_positions, :root_node

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
        @start_pos = pos
        @considered_positions = [pos]
        @root_node = PolyTreeNode.new(pos)
    end

    def new_move_positions(pos)
        valid = KnightPathFinder.valid_moves(pos).reject {|ele| @considered_positions.include?(ele)}
        @considered_positions+=valid
        valid
    end

    def build_move_tree
        queue=[@root_node]
        until queue.empty?
            deleted_node=queue.shift
            possible_moves=new_move_positions(deleted_node.value)
            nodes=[]
            possible_moves.each do |move|
                node=PolyTreeNode.new(move)
                node.parent=deleted_node
                nodes<<node
            end
            queue+=nodes
            # p queue
            # puts
        end
    end

    def trace_path_back(end_pos)
        new_arr = []
        new_arr << find_path_dfs(end_pos)
        until new_arr[0] == root_node
            new_arr.unshift(new_arr[0].parent)
        end
        new_arr
    end

    def find_path_bfs(end_pos)
        root_node.bfs(end_pos)
    end

    def find_path_dfs(end_pos)
        root_node.dfs(end_pos)
    end



end

k = KnightPathFinder.new([0,0])
# p KnightPathFinder.valid_moves([0,0])
# p KnightPathFinder.valid_moves([7,7])
# p k.new_move_positions([-1,7])
k.build_move_tree
# p k.find_path([3,3])
p k.trace_path_back([7,6])