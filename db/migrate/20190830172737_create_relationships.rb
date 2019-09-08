class CreateRelationships < ActiveRecord::Migration[6.0]
  def change
    create_table :relationships do |t|
      t.integer :befriender_id
      t.integer :befriended_id

      t.string :reln_type
      t.date :start
      t.string :quality

      t.timestamps
    end
    add_index :relationships, :befriender_id
    add_index :relationships, :befriended_id
    add_index :relationships, [:befriender_id, :befriended_id], unique: true
  end
end
