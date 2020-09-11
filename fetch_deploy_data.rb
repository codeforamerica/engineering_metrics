#! /usr/bin/env ruby

require 'rest-client'
require 'json'
require_relative 'circle_ci_client'

def fetch_gyr(start_date, end_date)
  CircleCiClient.get_deploys(start_date, end_date, 'gh/codeforamerica/vita-min', 'deploy-release-branch-to-production', 'release')
end

unless ARGV.count == 1
  puts "Please supply a date in the format MM/DD/YYYY. Deploys will be computed for the week ending on this date"
  exit(1)
end
date_input = ARGV[0]
end_date = DateTime.strptime(date_input, '%m/%d/%Y')
start_date = end_date - 7


# gcf_deploys = fetch_gcf
gyr_deploys = fetch_gyr start_date, end_date
# cmr_deploys = fetch_cmr
# shiba_deploys = fetch_shiba

puts "#{gyr_deploys} successful deploys"





