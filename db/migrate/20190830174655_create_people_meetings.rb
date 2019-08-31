class CreatePeopleMeetings < ActiveRecord::Migration[6.0]
  def change
    create_table :people_meetings do |t|
      t.integer :person_id
      t.integer :meeting_id
      
      t.string :feeling
      t.string :description
    end
  end
end
