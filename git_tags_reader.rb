class GitTagsReader
  def self.get_deploys(start_date, end_date, repo_path, tag_prefix, tag_date_format)
    Dir.chdir(repo_path) do
      system "git pull --ff-only"
      deploy_tags = `git tag -l #{tag_prefix}*`
      deploy_dates = deploy_tags
                       .split("\n")
                       .map { |t| DateTime.strptime(t.delete_prefix(tag_prefix), tag_date_format)}
                       .select { |d| d.between?(start_date, end_date) }
      deploy_dates.count
    end
  end
end
