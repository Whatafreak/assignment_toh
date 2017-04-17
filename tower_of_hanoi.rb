#!/usr/bin/ruby

=begin
class Tower

  attr_accessor :height, :col_1, :col_2, :col_3, :move, :from, :to

  def initialize(height)
    @height = height
    @col_1 = (1..@height).to_a
    @col_2 = []
    @col_3 = []
    @height.times do
      @col_2 << 0
      @col_3 << 0
    end
    puts "Welcome to Tower of Hanoi!"
    puts "Instructions:"
    puts "Enter where you'd like to move from and to"
    puts "in the format '1,3'. Enter 'q' to quit."
    self.print_status
    self.get_input
  end

  def get_input
    print "Enter move > "
    @move = gets.chomp.split(/,/)
    self.validate_input
  end

  def validate_input
    if @move.length == 2 && @move[0].to_i >= 1 && @move[1].to_i >= 1 && @move[0].to_i <= 3 && @move[1].to_i <= 3
      @from = @move[0].to_i
      @to = @move[1].to_i
      self.move_blocks
    elsif @move[0].downcase == "q"
      puts "You chose to quit your game. Thanks for playing!"
    else
      puts "Something was wrong with your move selection. Please use the format '1,3'."
      self.get_input
    end
  end

  def move_blocks
    col_1_position = @height - 1
    col_2_position = @height - 1
    col_3_position = @height - 1

    @height.times do |num|
      if @col_1[num] > 0
        col_1_position = num
        break
      end
      if @col_2[num] > 0
        col_2_position = num
        break
      end
      if @col_3[num] > 0
        col_3_position = num
        break
      end
    end

    if @from == 1
      if @to == 2
        @col_2[col_2_position],@col_1[col_1_position] = @col_1[col_1_position],@col_2[col_2_position]
      else @to == 3

      end
    elsif @from == 2
      if @to == 1

      elsif @to == 2

      else

      end
    else
      if @to == 1

      elsif @to == 2

      else

      end
    end


    self.check_if_won
  end

  def check_if_won
    if @col_3 == (1..@height).to_a
      puts "Congratulations! You've won the game!"
    else
      self.print_status
      self.get_input
    end
  end

  def print_status
    puts "Current tower configuration:"
    puts "----------------------------"
    @height.times do |num|
      puts "     #{@col_1[num]}       #{@col_2[num]}       #{@col_3[num]}"
    end
    puts "----------------------------"
  end

end

tower = Tower.new(3)
=end

# I was barking up the wrong tree back there!

class Towers
  attr_reader :towers, :winning_tower
  attr_accessor :moves

  def initialize(discs)
    @winning_tower = discs.downto(1).to_a
    @towers = (1..3).each_with_object({}) { |n, towers| towers[n] = [] }
    @towers[1] = @winning_tower.dup
    @moves = 0
  end

  def move(from, to)
    if !towers.include?(from)
      puts "Tower #{from} does not exist."
    elsif !towers.include?(to)
      puts "Tower #{to} does not exist."
    elsif from.equal?(to)
      puts "You can't put the same disc where you got it from!"
    elsif tower(to).any? && tower(to).last < tower(from).last
      puts "Invalid move. You can't place a bigger tile on top of a smaller one."
    else
      tower(to) << tower(from).pop
      self.moves += 1
    end
  end

  def over?
    winning_tower == tower(2) || winning_tower == tower(3)
  end

  def tower(number)
    towers[number]
  end
end

puts "How many discs would you like to start with?"
discs = gets.to_i
game = Towers.new(discs)

until game.over?
  puts "Here is how the game board looks right now:"
  game.towers.each { |number, tower| puts "Tower #{number}: #{tower}" }

  puts "Please select tower you want to chose from:"
  from = gets.chomp.to_i
  puts "Please select tower you want to place disc:"
  to = gets.chomp.to_i

  game.move(from, to)
end

puts "Game over! You've won in #{game.moves} moves!"
