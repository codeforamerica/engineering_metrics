require 'httparty'
require_relative 'secrets'

class CircleCiClient
  def self.get_deploys(start_date, end_date, project_slug, workflow_name, branch)
    headers = {
      'Accept' => 'application/json',
      'Circle-Token' => CIRCLE_CI_API_KEY
    }

    # date_format = '%Y-%m-%d'
    query_params = {
      'branch': branch,
      'start-date': start_date.to_s,
      'end-date': end_date.to_s
    }
    query_param_string = query_params.map {|k,v| "#{k}=#{v}"}.join('&')

    request_url = "https://circleci.com/api/v2/insights/#{project_slug}/workflows/#{workflow_name}?#{query_param_string}"
    response =  HTTParty.get request_url, headers: headers
    result = JSON.parse(response.body)
    deploys = result["items"]
    deploys.count if deploys
  end
end

