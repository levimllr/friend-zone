class CreateLoveLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :love_languages do |t|
      t.belongs_to :person

      t.integer :gifts_rank
      t.text :gifts_example
      t.integer :time_rank
      t.text :time_example
      t.integer :affirmation_rank
      t.text :affirmation_example
      t.integer :service_rank
      t.text :service_example
      t.integer :touch_rank
      t.text :touch_example

      t.timestamps
    end
  end
end
