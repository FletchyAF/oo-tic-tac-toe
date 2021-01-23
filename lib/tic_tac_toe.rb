require 'pry'

class TicTacToe

    WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
    
    def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    def display_board
        puts(" #{@board[0]} | #{@board[1]} | #{@board[2]} ")
        puts("-----------")
        puts(" #{@board[3]} | #{@board[4]} | #{@board[5]} ")
        puts("-----------")
        puts(" #{@board[6]} | #{@board[7]} | #{@board[8]} ")
    end

    def input_to_index(str)
        str.to_i - 1
    end

    def move(board_index, player_token)
        @board[board_index] = player_token
    end

    def position_taken?(board_index)
        if @board[board_index].strip != ""
            true
        else
            false
        end
    end

    def valid_move?(board_index)
        if board_index > 8 || board_index < 0
            return false
        end
        return !self.position_taken?(board_index) 
    end

    def turn_count
        return 9 - @board.count(" ")
    end

    def current_player
        if self.turn_count.even?
            return "X"
        else
            return "O"
        end
    end

    def turn
        puts "Enter Board Index Number: "
        input = gets
        index = self.input_to_index(input)
        while !self.valid_move?(index)
            input = gets
            index = self.input_to_index(input)
        end
        @board[index] = current_player
        display_board
    end

    def won?
       WIN_COMBINATIONS.each do |combo|
            if @board[combo[0]] == @board[combo[1]] && @board[combo[0]] == @board[combo[2]] && @board[combo[0]] != " "
                return combo
            end
        end
        return false
    end

    def full?    
        @board.each do |space|
            if space == " "
                return false
            end
        end
        return true
    end

    def draw?
        if full? && !won?
            return true
        end
            return false
    end

    def over?
        if full? || won?
            return true
        end
            return false
    end

    def winner
        winning_combo = won?
        if !winning_combo
            return nil
        end 
        return @board[winning_combo[0]]
    end

    def play
        display_board
        while !over? && !draw?
            turn
            display_board
        end
        if draw? 
            puts "Cat's Game!"
        else
            puts "Congratulations #{winner}!"
        end
    end

end