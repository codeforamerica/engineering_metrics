require 'rest-client'
require 'json'
require_relative 'circle_ci_client'

def fetch_gyr(start_date, end_date)
  CircleCiClient.get_deploys(start_date, end_date, 'gh/codeforamerica/vita-min', 'deploy-release-branch-to-production', 'release')
end

end_date = DateTime.now
start_date = end_date - 7



# gcf_deploys = fetch_gcf
gyr_deploys = fetch_gyr start_date, end_date
# cmr_deploys = fetch_cmr
# shiba_deploys = fetch_shiba

puts "#{gyr_deploys} successful deploys"





