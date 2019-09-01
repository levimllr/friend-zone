class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :befriender_id
      t.integer :befriendee_id
      t.string :reln_type
      t.date :start
      t.string :quality
    end
  end
end
