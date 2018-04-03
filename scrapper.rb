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
  players = [10185,669,2107,1488,1085,1979,1233,1162,33,873,1885,35,1193,8605,1343,1436,1195]
  user = 10
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
  names = ["Ishan Jaggi","KM Asif","K Jagadeesan","Mayank Markande","Kamlesh Nagarkoti","D'Arcy Short","Virat Kohli","Murugan Ashwin","MD Nidheesh","Shane Watson","Anukul Roy","Akila Dananjaya","Manoj Tiwary","Avesh Khan","Kulwant Kejroliya","Moshin Khan","Pawan Deshpande","MS Dhoni","Sayan Ghosh","Karn Sharma","Imran Tahir","Rahul Chahar"]
  ids = []
  names.each do |name|
    url = URI.parse('https://cbdream11.herokuapp.com/players/search/'+ name.to_s.gsub(" ", "%20") )
    req_options = {
      use_ssl: url.scheme == "https",
    }
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port, req_options) {|http|
      http.request(req)
    }
    if(res.to_s.strip.empty?)
      puts "couldn't find id for "  + name
    else
      puts name + " = " + res.to_s
      ids << res.to_s
    end
    puts ids
  end
end

# register
search
