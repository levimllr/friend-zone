class AddAdminToPeople < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :admin, :boolean, default: false
  end
end
