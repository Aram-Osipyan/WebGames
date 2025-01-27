class CreateRacerGames < ActiveRecord::Migration[7.1]
  def change
    create_table :racer_games do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
