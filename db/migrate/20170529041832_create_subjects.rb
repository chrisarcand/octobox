class CreateSubjects < ActiveRecord::Migration[5.1]
  def change
    create_table :subjects do |t|
      t.string :title
      t.string :url
      t.string :type

      t.timestamps
    end

    add_column(:notifications, :subject_id, :integer)
  end
end
