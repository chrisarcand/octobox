class Release < Subject
  def sync!(user, force: false)
    # Releases are immutable and we default the URL to the /releases index page anyway
  end
end
