class GithubActionsClient
  def self.get_deploys(start_date, end_date, repo_name, workflow_id, branch_name=nil)
    headers = {
      'Accept' => 'application/json',
      'Authorization' => "token #{GITHUB_TOKEN}"
    }

    request_url = "https://api.github.com/repos/codeforamerica/#{repo_name}/actions/workflows/#{workflow_id}/runs?status=success"
    request_url += "&branch=#{branch_name}" if branch_name
    response = HTTParty.get request_url, headers: headers
    result = JSON.parse(response.body)
    releases = result['workflow_runs'].
      map { |release| DateTime.parse(release['created_at']) }.
      select { |d| d.between?(start_date, end_date) }

    releases.count
  end
end
