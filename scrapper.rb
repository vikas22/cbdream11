require 'net/http'
require 'uri'
require 'json'
def scrapper
  uri = URI.parse("https://www.dream11.com/graphql")
  request = Net::HTTP::Post.new(uri)
  request.content_type = "application/json"
  request["Accept"] = "*/*"
  request["Accept-Language"] = "en-US,en;q=0.5"
  request["Connection"] = "keep-alive"
  request["Referer"] = "https://www.dream11.com/cricket/create-team/811/10514?returnUrl=https%3A%2F%2Fwww.dream11.com%2Fcricket%2Fleagues%2FIndian%2520T20%2520League%2F811%2F10514"
  request.body = JSON.dump({
    "query" => "query CreateTeamQuery( $site: String! $tourId: Int! $teamId: Int = -1 $matchId: Int!) { site(slug: $site) { name teamPreviewArtwork { src } teamCriteria { totalCredits maxPlayerPerSquad totalPlayerCount } roles { id artwork { src } color name pointMultiplier shortName } playerTypes { id name minPerTeam maxPerTeam shortName artwork { src } } tour(id: $tourId) { match(id: $matchId) { guru squads { flag { src } id jerseyColor name shortName } startTime status players(teamId: $teamId) { artwork { src } squad { id name jerseyColor shortName } credits id name points type { id maxPerTeam minPerTeam name shortName } isSelected role { id artwork { src } color name pointMultiplier shortName } } } } }}",
    "variables" => {
      "tourId" => 811,
      "matchId" => 10514,
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
  players = ["1516","8923","1250","5989","934", "2198", "1091", "1137", "1087", "1532", "1525", "2110", "1188", "1276", "994", "8874", "31", "1518", "692", "1882", "1833"]
  user = 13
    players.each do |player|

    puts player
    puts 'https://cbdream11.herokuapp.com/players/user/'+ player.to_s + '/' + user.to_s
    url = URI.parse('https://cbdream11.herokuapp.com/players/user/'+ player.to_s + '/' + user.to_s)
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

def search
  names = ["Daniel Christian","Aniket Choudary","Mark Wood","Andre Russell","Mayank Agarwal","Chris Woakes","Jasprit Bumrah","Sachin Baby","Shreyas Gopal","Pradeep Sahu","Dhruv Shenoy","Carlos Brathwaite","Dushmantha Chameera","Mohammad Nabi","Tanmay Agarwal","Parthiv Patel","Manan Vohra","Saurabh Tiwary","Gurkeerat Singh ","Ricky Bhui","Billy Stanlake"]
  ids = []
  names.each do |name|
    # name ="D'Arcy Short"
    url = URI.parse('https://cbdream11.herokuapp.com/players/search/'+ name.to_s.gsub(" ", "%20") )
    req_options = {
      use_ssl: url.scheme == "https",
    }
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port, req_options) {|http|
      http.request(req)
    }

    if(res.body.to_s.strip.empty?)
      puts "couldn't find id for "  + name
    else
      puts name + " = " + res.body.to_s
      ids << res.body.to_s
    end

   end
     puts ids.to_s
end

scrapper

# register
# search
