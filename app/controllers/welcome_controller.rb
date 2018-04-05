class WelcomeController < ApplicationController

  def index
    @users = User.where.not(id: 1)
    @captains = {}
    @vice_captains = {}
    ids = []
    @users.each do |user|
      ids << user.id
    end
    @players = Player.where.not(user_id: 1).group_by(&:user_id)
      @players.each do |user_id, players|
        players.each do |player|
          if(player.is_captain)
            @captains[user_id]= player
          end
          if(player.is_vice_captain)
            @captains[user_id]= player
          end
        end
      end

  end

end
