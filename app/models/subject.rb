class Subject < ApplicationRecord
  has_many :notifications

  validates :type,  presence: true
  validates :title, presence: true
  validates :url,   presence: true

  ##
  # Makes the appropriate request to Github and syncs the subject with the
  # response's data.
  #
  # * Subclasses are required to implement their own sync strategy.
  # * Subclasses are not expected to sync data that is considered immutable on Github without the :force option
  #   Example: a commit's attributes never change. There's no point in wasting a request to ensure
  #   data is in sync, so by default a sync just isn't performed.
  # * A user is required for the authorized request to Github.
  #
  # @param [User] user The user who will be making the sync request
  # @option [Boolean] :force Forces syncing of data that wouldn't normally be synced (because it is considered immutable)
  def sync!(user, force: false)
    raise NotImplementedError
  end
end
