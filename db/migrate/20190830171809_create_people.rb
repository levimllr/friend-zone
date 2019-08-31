class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :username
      t.string :password

      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :email
      t.integer :phone_number

      t.integer :love_language_id
      
      t.timestamps
    end
  end
end
