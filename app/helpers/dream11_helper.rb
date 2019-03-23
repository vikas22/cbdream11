require 'net/http'
require 'uri'
require 'json'

module Dream11Helper

  # def makeRequest(body)
  #   uri = URI.parse("https://www.dream11.com/graphql")
  #   request = Net::HTTP::Post.new(uri)
  #   request.content_type = "application/json"
  #   request["Cache-Control"] = "no-cache"
  #   request.body = body
  #   req_options = {
  #     use_ssl: uri.scheme == "https",
  #   }
  #
  #   response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
  #     http.request(request)
  #   end
  #   response.body
  # end
  #
  # def getTeams(tourId, matchId)
  #   body = JSON.dump({
  #     "query" => "query CreateTeamQuery( $site: String! $tourId: Int! $teamId: Int = -1 $matchId: Int!) { site(slug: $site) { name teamPreviewArtwork { src } teamCriteria { totalCredits maxPlayerPerSquad totalPlayerCount } roles { id artwork { src } color name pointMultiplier shortName } playerTypes { id name minPerTeam maxPerTeam shortName artwork { src } } tour(id: $tourId) { match(id: $matchId) { guru squads { flag { src } id jerseyColor name shortName } startTime status players(teamId: $teamId) { artwork { src } squad { id name jerseyColor shortName } credits id name points type { id maxPerTeam minPerTeam name shortName } isSelected role { id artwork { src } color name pointMultiplier shortName } } } } }}",
  #     "variables" => {
  #       "tourId" => tourId,
  #       "matchId" => matchId,
  #       "teamId" => nil,
  #       "site" => "cricket"
  #     }
  #   })
  #   makeRequest(body)
  # end

  def getTeams(tourId, matchId)
    uri = URI.parse("https://www.dream11.com/graphql/query/pwa/shme-create-team-query")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Cookie"] = "amp-experiment=amp-PrsQ4tSgl-dLx9hJqoxOVA; __csrf=9a6ca435-7ed4-c3d0-e5bf-a18db8fb035e; G_ENABLED_IDPS=google; ajs_user_id=null; ajs_group_id=null; ajs_anonymous_id=%22f624514d-3809-4a96-9991-f270411c6e20%22; amplitude_idundefineddream11.com=eyJvcHRPdXQiOmZhbHNlLCJzZXNzaW9uSWQiOm51bGwsImxhc3RFdmVudFRpbWUiOm51bGwsImV2ZW50SWQiOjAsImlkZW50aWZ5SWQiOjAsInNlcXVlbmNlTnVtYmVyIjowfQ==; WZRK_G=01dbb76d833d4e72ade5a17893f3c5db; ki_r=; connect.sid=s%3AW6B_uSNa280TKiSVBSpeDG70w3I8TDrg.JTHUrAKcjnB%2BsM1TYU3wGOFMVnfh7YGX6Jy3IuF3cuk; amplitude_id_6d8385f9bbeae68263f41eca9918e1c9dream11.com=eyJkZXZpY2VJZCI6IjY1NDFmZWE1LWU3MWEtNGUyNC05N2U3LThmNDkwODc3NjBiNVIiLCJ1c2VySWQiOm51bGwsIm9wdE91dCI6ZmFsc2UsInNlc3Npb25JZCI6MTU1Mjk4MTQ5OTM1NSwibGFzdEV2ZW50VGltZSI6MTU1Mjk4MzUwMTEzOSwiZXZlbnRJZCI6NDgsImlkZW50aWZ5SWQiOjIsInNlcXVlbmNlTnVtYmVyIjo1MH0=; _gid=GA1.2.1276788240.1553330953; _ga_6NJVXEJHSD=GS1.1.1553330953.1.0.1553330953.0; _ga=GA1.2.amp-Xq8DH4lC55FfU-11yvONwQ; _dc_gtm_UA-123645370-1=1; ki_t=1552565216169%3B1553330959437%3B1553330959437%3B4%3B9; _gat_UA-123645370-1=1; WZRK_S_W4R-49K-494Z=%7B%22p%22%3A2%2C%22s%22%3A1553330957%2C%22t%22%3A1553330983%7D"
    request["Origin"] = "https://www.dream11.com"
    request["Accept-Language"] = "en-GB,en-US;q=0.9,en;q=0.8"
    request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36"
    request["Accept"] = "*/*"
    request["Referer"] = "https://www.dream11.com/cricket/create-team/#{matchId}/#{tourId}?returnUrl=%2Fcricket%2Fleagues%2Fipl%2F#{matchId}%#{tourId}"
    request["Authority"] = "www.dream11.com"
    request["Device"] = "pwa"
    request["X-Csrf"] = "9a6ca435-7ed4-c3d0-e5bf-a18db8fb035e"
    request.body = JSON.dump({
      "query" => "query ShmeCreateTeamQuery( $site: String! $tourId: Int! $teamId: Int = -1 $matchId: Int!) { site(slug: $site) { name teamPreviewArtwork { src } teamCriteria { totalCredits maxPlayerPerSquad totalPlayerCount } roles { id artwork { src } color name pointMultiplier shortName } playerTypes { id name minPerTeam maxPerTeam shortName artwork { src } } tour(id: $tourId) { match(id: $matchId) { id guru squads { flag { src } flagWithName { src } id jerseyColor name shortName } startTime status players(teamId: $teamId) { artwork { src } squad { id name jerseyColor shortName } credits id name points type { id maxPerTeam minPerTeam name shortName } isSelected role { id artwork { src } color name pointMultiplier shortName } } tour { id } } } } me { isGuestUser showOnboarding }}",
      "variables" => {
        "tourId" => tourId,
        "matchId" => matchId,
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

    response.body
  end

  def getScoreCard(tourId, matchId)
    uri = URI.parse("https://www.dream11.com/graphql")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Accept"] = "*/*"
    request["Accept-Language"] = "en-US,en;q=0.5"
    request["Connection"] = "keep-alive"
    request["Referer"] = "https://www.dream11.com/cricket/fantasy-scorecard/#{tourId}/#{matchId}"
    request.body = JSON.dump({
      "query" => "query FantasyScoreCard($site: String!, $tourId: Int!, $matchId: Int!) { site(slug: $site) { fantasyScoreCardHeader { name } tour(id: $tourId) { match(id: $matchId) { status squads { name shortName flag { src } } fantasyScoreCard { players { player { name } fantasyPoints { score } } } } } }}",
      "variables" => {
        "tourId" => tourId,
        "matchId" => matchId,
        "site" => "cricket"
      }
    })

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    response.body
  end
end
