class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.integer :person_id
      t.integer :friend_id
      t.integer :people_meeting_id
      
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
