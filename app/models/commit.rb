class Commit < Subject
  def sync!(user, force: false)
    raise "No commit URL present" if url.blank?
    return unless force # Commits are immutable, so only sync if forced

    /(?<repo_name>\w+\/\w+)\/commit\/(?<commit_sha>[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})\z/ =~ url
    octokit_response = user.github_client.issue(repo_name, commit_sha)

    self.title = octokit_response.commit.message.split("\n").first

    save! if changed?
  end
end
