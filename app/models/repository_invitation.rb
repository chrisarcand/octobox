class RepositoryInvitation < Subject
  def sync!(user, force: false)
    # Invitations are immutable
  end
end
