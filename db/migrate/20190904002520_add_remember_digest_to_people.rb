class AddRememberDigestToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :remember_digest, :string
  end
end
