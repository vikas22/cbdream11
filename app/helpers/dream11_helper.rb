require 'net/http'
require 'uri'
require 'json'

module Dream11Helper

  def makeRequest(body)
    uri = URI.parse("https://www.dream11.com/graphql")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Cache-Control"] = "no-cache"
    request.body = body
    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    response.body
  end

  def getTeams(tourId, matchId)
    body = JSON.dump({
      "query" => "query CreateTeamQuery( $site: String! $tourId: Int! $teamId: Int = -1 $matchId: Int!) { site(slug: $site) { name teamPreviewArtwork { src } teamCriteria { totalCredits maxPlayerPerSquad totalPlayerCount } roles { id artwork { src } color name pointMultiplier shortName } playerTypes { id name minPerTeam maxPerTeam shortName artwork { src } } tour(id: $tourId) { match(id: $matchId) { guru squads { flag { src } id jerseyColor name shortName } startTime status players(teamId: $teamId) { artwork { src } squad { id name jerseyColor shortName } credits id name points type { id maxPerTeam minPerTeam name shortName } isSelected role { id artwork { src } color name pointMultiplier shortName } } } } }}",
      "variables" => {
        "tourId" => tourId,
        "matchId" => matchId,
        "teamId" => nil,
        "site" => "cricket"
      }
    })
    makeRequest(body)
  end
end
