class RemoveSubjectColumnsFromNotifications < ActiveRecord::Migration[5.1]
  def up
    remove_columns(:notifications, :subject_title, :subject_url, :subject_type)
  end

  def down
    add_column(:notifications, :subject_title, :string)
    add_column(:notifications, :subject_url, :string)
    add_column(:notifications, :subject_type, :string)
  end
end
