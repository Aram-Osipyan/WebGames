class CreateQuizGames < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_games do |t|
      t.references :user, null: false, foreign_key: true
      t.jsonb :game_state # stores questions, answers, score, etc.
      t.datetime :active_until
      t.integer :score, default: 0
      t.integer :correct_answers, default: 0
      t.integer :total_questions, default: 10
      t.boolean :completed, default: false
      t.datetime :completed_at
      t.timestamps
    end

    add_index :quiz_games, :active_until
    add_index :quiz_games, :completed
    add_index :quiz_games, :score
    add_index :quiz_games, :completed_at
  end
end