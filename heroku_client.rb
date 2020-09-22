require 'httparty'
require_relative 'secrets'

class HerokuClient
  def self.get_deploys(start_date, end_date, app_name, starting_version)
    headers = {
      'Accept' => 'application/vnd.heroku+json; version=3',
      'Authorization' => "Bearer #{HEROKU_API_KEY}",
      'Range' => "version #{starting_version}.."
    }

    request_url = "https://api.heroku.com/apps/#{app_name}/releases"
    response = HTTParty.get request_url, headers: headers
    result = JSON.parse(response.body)
    releases = result.
      select { |release| release['status'] == 'succeeded' }.
      map { |release| DateTime.parse(release['created_at']) }.
      select { |d| d.between?(start_date, end_date) }

    releases.count
  end
end

