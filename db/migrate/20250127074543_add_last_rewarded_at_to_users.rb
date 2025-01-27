class AddLastRewardedAtToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_rewarded_at, :datetime
  end
end
