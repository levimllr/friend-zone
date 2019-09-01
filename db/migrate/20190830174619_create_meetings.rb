class CreateMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :meetings do |t|
      t.string :meeting_type
      t.datetime :when
      t.string :location
      t.integer :friend_id

      t.timestamps
    end
  end
end
