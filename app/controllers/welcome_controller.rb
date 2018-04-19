class WelcomeController < ApplicationController

  def index
    @users = User.where.not(id: 1).group_by(&:id)
    @captains = {}
    @vice_captains = {}
    @total = {}
    @top11 = {}
    @players = Player.where.not(user_id: 1).group_by(&:user_id)
      @players.each do |user_id, players|
        sum = 0
        scores = []
        players.each do |player|
          total = player.player_scores.sum(:total)
          score = 0
          if(player.is_captain)
            score = (total * 2)
            sum = sum + score
            @captains[user_id]= player
          elsif(player.is_vice_captain)
            score = (total * 1.5)
            sum = sum + score
            @vice_captains[user_id]= player
          else
            score = total
            sum = sum + total
          end
          scores << score
        end
        scores = scores.sort.reverse
        index = if(scores.length >= 10)then 10 else scores.length end
        top11Sum = 0
        for i in 0..index
          if(scores[i]!=nil)
            top11Sum = top11Sum + scores[i]
          end
        end
        @top11[user_id] = top11Sum
        @total[user_id] = sum
      end

      # @total = @total.sort_by {|k, v| v}.reverse
      @top11 = @top11.sort_by {|k, v| v}.reverse

  end

end
