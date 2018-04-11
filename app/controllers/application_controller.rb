require 'net/http'
require 'uri'
require 'json'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Dream11Helper
  def scrap
    response = getTeams(params[:tourId], params[:matchId])
    response_hash =JSON.parse(response).to_hash
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

  def scrapScoreCard
    response = getScoreCard(params[:tourId], params[:matchId])
    response_hash =JSON.parse(response).to_hash
    response_hash["data"]["site"]["tour"]["match"]["fantasyScoreCard"]
    match_details = response_hash["data"]["site"]["tour"]["match"]["squads"][0]["name"] + " vs " +  response_hash["data"]["site"]["tour"]["match"]["squads"][1]["name"]

    response_hash["data"]["site"]["tour"]["match"]["fantasyScoreCard"]["players"].each do |player_score_dream11|
      player = Player.find_by(name: player_score_dream11["player"]["name"])
      player_score = PlayerScore.where(player_id:player.id, match_id:params[:matchId]).first_or_create
        player_score.player_id = player.id
        player_score.starting_11 = player_score_dream11["fantasyPoints"][0]["score"].to_f
        player_score.runs = player_score_dream11["fantasyPoints"][1]["score"].to_f
        player_score.fours = player_score_dream11["fantasyPoints"][2]["score"].to_f
        player_score.sixes = player_score_dream11["fantasyPoints"][3]["score"].to_f
        player_score.str = player_score_dream11["fantasyPoints"][4]["score"].to_f
        player_score.centuries = player_score_dream11["fantasyPoints"][5]["score"].to_f
        player_score.duck = player_score_dream11["fantasyPoints"][6]["score"].to_f
        player_score.wkts = player_score_dream11["fantasyPoints"][7]["score"].to_f
        player_score.maiden = player_score_dream11["fantasyPoints"][8]["score"].to_f
        player_score.er = player_score_dream11["fantasyPoints"][9]["score"].to_f
        player_score.bonus = player_score_dream11["fantasyPoints"][10]["score"].to_f
        player_score.catches = player_score_dream11["fantasyPoints"][11]["score"].to_f
        player_score.runout = player_score_dream11["fantasyPoints"][12]["score"].to_f
        player_score.total = player_score_dream11["fantasyPoints"][13]["score"].to_f
        player_score.match_id = params[:matchId].to_i
        player_score.match = match_details
        player_score.save
    end
    render plain: response_hash["data"]["site"].to_json
  end

  def destroyUser
    players = Player.where(user_id: params[:id])
    players.each do |player|
      PlayerScore.where(player_id: player.id).destroy_all
    end
    render plain: "DONE"
  end
end
