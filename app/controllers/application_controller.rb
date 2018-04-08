require 'net/http'
require 'uri'
require 'json'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Dream11Helper
  def scrap
    response = getTeams(params[:tourId], params[:matchId])
     response_hash =JSON.parse(response).to_hash
    puts "----------------"
    puts response_hash
    puts "----------------"
    names = []
    response_hash["data"]["site"]["tour"]["match"]["players"].each {|x|
      begin
        team  = Team.find_or_create_by(name: x["squad"]["shortName"], id:x["squad"]["id"])
        player = Player.find(x["id"])
      rescue ActiveRecord::RecordNotFound
        Player.find_or_create_by(id: x["id"],name: x["name"],team: team, user_id: 1, is_vice_captain:false, is_captain:false)
      end

    }
    render plain: response_hash["data"]["site"]["tour"]["match"]["players"].to_json
  end
end
