class AddGameToAdmins < ActiveRecord::Migration[7.1]
  def change
    add_column :admins, :game, :string
  end
end
