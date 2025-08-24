class CreateQuizQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :quiz_questions do |t|
      t.text :question_text, null: false
      t.string :option_a, null: false
      t.string :option_b, null: false
      t.string :option_c, null: false
      t.string :option_d, null: false
      t.string :correct_answer, null: false # 'A', 'B', 'C', or 'D'
      t.string :category
      t.integer :difficulty, default: 1 # 1-easy, 2-medium, 3-hard
      t.boolean :active, default: true
      t.datetime :active_from
      t.datetime :active_until
      t.timestamps
    end

    add_index :quiz_questions, :active
    add_index :quiz_questions, :category
    add_index :quiz_questions, :difficulty
    add_index :quiz_questions, [:active_from, :active_until]
  end
end