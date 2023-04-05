require_relative 'player'
require_relative 'question'

class Game
  def initialize
    @players = [Player.new("Player 1"), Player.new("Player 2")]
    @current_player_index = 0
  end

  def start
    loop do
      puts "----- NEW TURN -----"
      player = @players[@current_player_index]
      question = Question.new

      puts "#{player.name}: #{question.question}"
      answer = gets.chomp.to_i

      if question.correct_answer?(answer)
        puts "You are correct!"
        player.increase_score
      else
        puts "You are incorrect!"
        player.reduce_life
      end

      puts "Score: #{player.score}/3"
      puts "#{player.name} has #{player.lives} lives remaining"

      if game_over?
        puts "----- GAME OVER -----"
        winner = @players.max_by { |player| player.score }
        loser = @players.min_by { |player| player.score }
        puts "#{winner.name} wins with a score of #{winner.score}/3"
        puts "#{loser.name} had a score of #{loser.score}/3"
        break
      end

      switch_player
    end
  end

  private

  def game_over?
    @players.any? { |player| !player.alive? }
  end

  def switch_player
    @current_player_index = (@current_player_index + 1) % @players.length
  end
end