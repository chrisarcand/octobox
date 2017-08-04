class Issue < Subject
  def sync!(user, force: false)
    raise "No issue URL present" if url.blank?

    /(?<repo_name>\w+\/\w+)\/issues\/(?<issue_number>\d+)\z/ =~ url
    octokit_response = user.github_client.issue(repo_name, issue_number)

    self.title = octokit_response.title

    save! if changed?
  end
end
