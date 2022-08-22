require "pry"


class TicTacToe
    WIN_COMBINATIONS= [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

   def initialize
        @board=[]
        9.times {@board<<" "}
    end

    def  display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} -----------\n #{@board[3]} | #{@board[4]} | #{@board[5]} -----------\n #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input.to_i-1
    end

    def move(index,piece)
        @board[index]=piece
    end
    
    def position_taken?(index)
        @board[index] !=" "?true:false
    end

    def valid_move?(index)
        (position_taken?(index) || index<0 || index>8)?false:true
    end

    def turn_count
        @board.grep(/[X,O]/).length
    end

    def current_player
        turn_count%2==0?"X":"O"
    end

    def turn
        index=input_to_index(gets.chomp)
        if valid_move?(index)
            move(index,current_player)
            display_board
        else
            turn
        end
    end

    def current_situation
        for_X=[]
        for_O=[]
        @board.each.with_index do |piece,index|
            if piece=="X"
                for_X << index
            elsif piece=="O"
                for_O << index
            end
        end
        {X:for_X,O:for_O}
    end

    def possible(piece_situation)
        piece_situation.combination(3).to_a
    end



    def check(possibles)
       pos= possibles.find do |pos|
            WIN_COMBINATIONS.include?(pos)
        end
        pos ?pos:[]
    end

    def won?
          who ? who[1]: false
    end

    def full? 
       !@board.include?(" ")
    end

    def draw?
        !(!full? || won?)
    end

    def over?
        draw? || won?
    end

    def who
        situation=current_situation
        if !check(possible(situation[:X])).empty?
            ["X",check(possible(situation[:X]))]
        elsif !check(possible(situation[:O])).empty?
           ["O",check(possible(situation[:O]))]
        end
    end

    def winner
        who ? who[0]: who
    end

    def play
        until over?
            turn
        end
        winner ? (puts "Congratulations #{winner}!") : (puts "Cat's Game!")
    end
end

# tic=TicTacToe.new
# tic.display_board
