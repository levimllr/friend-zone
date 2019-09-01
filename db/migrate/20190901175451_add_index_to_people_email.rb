class AddIndexToPeopleEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :people, :email, unique: true
  end
end
