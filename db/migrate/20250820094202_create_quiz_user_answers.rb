class CreateQuizUserAnswers < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_user_answers do |t|
      t.references :quiz_game, null: false, foreign_key: true
      t.references :quiz_question, null: false, foreign_key: true
      t.string :selected_answer # 'A', 'B', 'C', or 'D'
      t.boolean :is_correct
      t.integer :time_taken # in seconds
      t.boolean :hint_used, default: false
      t.timestamps
    end

    add_index :quiz_user_answers, [:quiz_game_id, :quiz_question_id], unique: true
    add_index :quiz_user_answers, :is_correct
    add_index :quiz_user_answers, :hint_used
  end
end