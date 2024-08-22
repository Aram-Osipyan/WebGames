class AddUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :external_id

      t.timestamps
    end

    create_table :authentication_lines do |t|
      t.integer :user_id
      t.string :code
      t.boolean :active
      t.datetime :active_until

      t.timestamps
    end

    create_table :wordle_games do |t|
      t.integer :user_id
      t.jsonb :game_state
      t.datetime :active_until
      t.integer :day_word_id

      t.timestamps
    end
  end
end
