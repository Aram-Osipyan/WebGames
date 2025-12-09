class AddGameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :game, :string
  end
end
