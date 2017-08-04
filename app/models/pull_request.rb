class PullRequest < Subject
  def sync!(user, force: false)
    raise "No pull request URL present" if url.blank?

    /(?<repo_name>\w+\/\w+)\/pulls\/(?<pr_number>\d+)\z/ =~ url
    octokit_response = user.github_client.pull_request(repo_name, pr_number)

    self.title = octokit_response.title

    save! if changed?
  end
end
