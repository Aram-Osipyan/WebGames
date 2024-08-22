class CreateDayWords < ActiveRecord::Migration[7.1]
  def change
    create_table :day_words do |t|
      t.string :word
      t.datetime :active_until
      t.boolean :active, default: false, null: false

      t.timestamps
    end
  end
end
