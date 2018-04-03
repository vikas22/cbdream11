class WelcomeController < ApplicationController

  def index
    @users = User.all()
    ids = []
    @users.each do |user|
      ids << user.id
    end
    @counts = Player.where(user_id:ids).group(:user_id).size
  end

end
