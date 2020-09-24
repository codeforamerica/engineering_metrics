#! /usr/bin/env ruby

require 'rest-client'
require 'json'
require_relative 'circle_ci_client'
require_relative 'heroku_client'
require_relative 'github_actions_client'
require_relative 'git_tags_reader'
require_relative 'secrets'

def fetch_gyr(start_date, end_date)
  CircleCiClient.get_deploys(start_date, end_date, 'gh/codeforamerica/vita-min', 'deploy-release-branch-to-production', 'release')
end

def fetch_gcf(start_date, end_date)
  GitTagsReader.get_deploys(start_date, end_date, GCF_REPO_PATH, 'deploy-production-', '%Y-%m-%d_%H-%M-%S')
end

def fetch_cmr(start_date, end_date)
  HerokuClient.get_deploys(start_date, end_date, 'intake-production', '62')
end

def fetch_shiba(start_date, end_date)
  GithubActionsClient.get_deploys(start_date, end_date, '2564543')
end

unless ARGV.count == 1
  puts "Please supply a date in the format MM/DD/YYYY. Deploys will be computed for the week ending on this date"
  exit(1)
end
date_input = ARGV[0]
end_date = DateTime.strptime(date_input, '%m/%d/%Y')
start_date = end_date - 7


gcf_deploys = fetch_gcf start_date, end_date
gyr_deploys = fetch_gyr start_date, end_date
cmr_deploys = fetch_cmr start_date, end_date
shiba_deploys = fetch_shiba start_date, end_date

puts "GCF: #{gcf_deploys} deploys"
puts "GYR: #{gyr_deploys} deploys"
puts "CMR: #{cmr_deploys} deploys"
puts "SHIBA: #{shiba_deploys} deploys"

puts "\n\nSummary:"
puts "#{date_input}\t#{gcf_deploys}\t#{gyr_deploys}\t#{cmr_deploys}\t#{shiba_deploys}"





