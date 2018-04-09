class WelcomeController < ApplicationController

  def index
    @users = User.where.not(id: 1).group_by(&:id)
    @captains = {}
    @vice_captains = {}
    @total = {}
    @players = Player.where.not(user_id: 1).group_by(&:user_id)
      sum = 0
      @players.each do |user_id, players|
        players.each do |player|
          total = player.player_scores.sum(:total)
          if(player.is_captain)
            sum = sum + (total * 2)
            @captains[user_id]= player
          elsif(player.is_vice_captain)
            sum = sum +  (total * 1.5)
            @vice_captains[user_id]= player
          else
            sum = sum + total
          end
        end
        @total[user_id] = sum
      end
      @total.sort_by {|k, v| v}
      puts @total
  end

end
