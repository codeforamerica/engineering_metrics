class GithubActionsClient
  def self.get_deploys(start_date, end_date, workflow_id)
    headers = {
      'Accept' => 'application/json'
    }

    request_url = "https://api.github.com/repos/codeforamerica/shiba/actions/workflows/#{workflow_id}/runs?status=success"
    response = HTTParty.get request_url, headers: headers
    result = JSON.parse(response.body)
    releases = result['workflow_runs'].
      map { |release| DateTime.parse(release['created_at']) }.
      select { |d| d.between?(start_date, end_date) }

    releases.count
  end
end
