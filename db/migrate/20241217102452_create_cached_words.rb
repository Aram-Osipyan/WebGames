class CreateCachedWords < ActiveRecord::Migration[7.1]
  def change
    create_table :cached_words do |t|
      t.string :word
      
      t.timestamps
      t.index [ :word], name: "index_word_on_cached_words", unique: true
    end
  end
end
