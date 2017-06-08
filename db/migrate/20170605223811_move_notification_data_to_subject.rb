class MoveNotificationDataToSubject < ActiveRecord::Migration[5.1]
  class Notification < ActiveRecord::Base
    belongs_to :subject
  end

  class Subject < ActiveRecord::Base
    self.inheritance_column = :_type_disabled
    has_many :notifications
  end

  def up
    Notification.find_in_batches do |notifications|
      notifications.each do |notification|
        next unless notification.subject_url
        subject = Subject.find_by(url: notification.subject_url) || Subject.new(url: notification.subject_url)
        subject.title = notification.subject_title if subject.title != notification.subject_title
        subject.type = notification.subject_type if subject.type != notification.subject_type
        subject.save! if subject.changed?

        notification.subject_id = subject.id
        notification.save!
      end
    end
  end

  def down
    Subject.find_in_batches do |subjects|
      subjects.each do |subject|
        subject.notifications.each do |notification|
          notification.subject_url = subject.url
          notification.subject_title = subject.title
          notification.subject_type = subject.type
          notification.save!
        end
      end
    end

    Subject.delete_all
  end
end
