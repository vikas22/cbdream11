require 'net/http'
require 'uri'
require 'json'
def scrapper
  uri = URI.parse("https://www.dream11.com/graphql")
  request = Net::HTTP::Post.new(uri)
  request.content_type = "application/json"
  request["Cache-Control"] = "no-cache"
  request.body = JSON.dump({
    "query" => "query CreateTeamQuery( $site: String! $tourId: Int! $teamId: Int = -1 $matchId: Int!) { site(slug: $site) { name teamPreviewArtwork { src } teamCriteria { totalCredits maxPlayerPerSquad totalPlayerCount } roles { id artwork { src } color name pointMultiplier shortName } playerTypes { id name minPerTeam maxPerTeam shortName artwork { src } } tour(id: $tourId) { match(id: $matchId) { guru squads { flag { src } id jerseyColor name shortName } startTime status players(teamId: $teamId) { artwork { src } squad { id name jerseyColor shortName } credits id name points type { id maxPerTeam minPerTeam name shortName } isSelected role { id artwork { src } color name pointMultiplier shortName } } } } }}",
    "variables" => {
      "tourId" => 811,
      "matchId" => 10512,
      "teamId" => nil,
      "site" => "cricket"
    }
  })

  req_options = {
    use_ssl: uri.scheme == "https",
  }

  response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
    http.request(request)
  end

  puts response.code
  puts response.body.to_json
end

def register
  players = [1495,1513,896,431,99,1453,1364,1161,8793,1517]
  user = 6
    players.each do |player|

    puts player
    puts 'https://shielded-forest-33649.herokuapp.com/players/user/'+ player.to_s + '/' + user.to_s
    url = URI.parse('https://shielded-forest-33649.herokuapp.com/players/user/'+ player.to_s + '/' + user.to_s)
    req_options = {
      use_ssl: url.scheme == "https",
    }
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port, req_options) {|http|
      http.request(req)
    }
    puts res.body
  end
end

register
