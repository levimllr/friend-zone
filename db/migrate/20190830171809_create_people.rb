class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :username
      t.string :password_digest

      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :email
      t.bigint :phone_number
      
      t.timestamps
    end
  end
end
